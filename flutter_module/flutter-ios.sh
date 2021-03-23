#!/bin/sh
#将代码保存到flutter_app目录下命名为flutter-ios.sh

function echoError() {
    echo '\033[31mError:'$1'\033[0m'
}

function echoGreen() {
echo '\033[32m'$1'\033[0m'
}

#debug/release
function buildFlutter() {

    mode='release'
    if [ $# = 1 ] ; then
        mode=$1
    fi

    buildRoot='build/flutter-ios/'
    buildPath=$buildRoot$mode'-iphoneos/'
    buildRootPlugins=$buildRoot'plugins/'

    rm -rf $buildPath
    mkdir -p $buildPath

    #编译flutter
    echoGreen 'flutter build ios --'$mode
    flutter build ios --$mode

    #加载Flutter.framework
    flutterFramework='ios/Flutter/Flutter.framework'
    if [ ! -d $flutterFramework ]; then
        echoError 'Flutter.framework不存在'
        exit 0
    else
        echoGreen '加载Flutter.framework'
        cp -r $flutterFramework $buildPath
    fi

    #加载App.framework
    appFramework='ios/Flutter/App.framework'
    if [ ! -d $appFramework ]; then
        echoError 'App.framework不存在'
        exit 0
    else
        echoGreen '加载App.framework'
        cp -r $appFramework $buildPath
    fi

########################################

    #加载plugins
    if [ ! -d $buildRootPlugins ]; then
        mkdir -p $buildRootPlugins
        flutterPlugins='.flutter-plugins'
        if [ -f $flutterPlugins ]; then
            while read line 
            do
                array=(${line//=/ }) 
                pluginPath=$buildRootPlugins${array[0]} 
                mkdir -p $pluginPath
                cp -r ${array[1]}'/ios/.' $pluginPath
            done < $flutterPlugins
        fi
    fi
    echoGreen '加载plugins'
    ln -fs '../plugins' $buildPath'plugins'
    #注册文件
    if [ ! -f $buildRoot'GeneratedPluginRegistrant.h' ]; then
        flutterPluginsRegistrant='ios/Runner/GeneratedPluginRegistrant'
        if [ -f $flutterPluginsRegistrant'.h' ]; then
            cp -r $flutterPluginsRegistrant'.h' $buildRoot
            cp -r $flutterPluginsRegistrant'.m' $buildRoot
        fi
    fi
    ln -fs '../GeneratedPluginRegistrant.h' $buildPath'GeneratedPluginRegistrant.h'
    ln -fs '../GeneratedPluginRegistrant.m' $buildPath'GeneratedPluginRegistrant.m'

    #加载flutter_assets
    if [ ! -d $buildRoot'flutter_assets' ]; then
        flutterAssets='ios/Flutter/flutter_assets'
        if [ -d $flutterAssets ]; then
            cp -r $flutterAssets $buildRoot
        fi
    fi
    echoGreen '加载flutter_assets'
    ln -fs '../flutter_assets' $buildPath'flutter_assets'
    

    #复制Flutter.podspec
    if [ ! -f $buildRoot'Flutter.podspec' ]; then
        flutterPodspec='Flutter.podspec'
        if [ -f $flutterPodspec ]; then
            cp -r $flutterPodspec $buildRoot
        fi
    fi
    echoGreen '加载Flutter.podspec'
    ln -fs '../Flutter.podspec' $buildPath'Flutter.podspec'
}

start=$(date +%s)

#编译
rm -rf 'build/flutter-ios/'
mkdir -p 'build/flutter-ios/'
buildFlutter debug
buildFlutter release

end=$(date +%s)
echo '^v^制作完成,耗时:'$(( $end - $start ))'s'