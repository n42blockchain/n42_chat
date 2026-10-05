pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.13.2" apply false
    id("org.jetbrains.kotlin.android") version "2.4.20" apply false
}

// Keep legacy Flutter plugins buildable with the current Android Gradle Plugin.
gradle.beforeProject {
    if (project.name != "app" && project.name != rootProject.name) {
        project.afterEvaluate {
            val android = project.extensions.findByName("android")
            if (android is com.android.build.gradle.LibraryExtension) {
                val compileSdkApi = android.compileSdkVersion
                    ?.removePrefix("android-")
                    ?.substringBefore('.')
                    ?.toIntOrNull()
                if (compileSdkApi == null || compileSdkApi < 36) {
                    android.compileSdkVersion(36)
                }
                if (android.namespace.isNullOrEmpty()) {
                    val manifestFile = project.file("src/main/AndroidManifest.xml")
                    if (manifestFile.exists()) {
                        val content = manifestFile.readText()
                        val match = """package\s*=\s*["']([^"']+)["']"""
                            .toRegex()
                            .find(content)
                        if (match != null) {
                            android.namespace = match.groupValues[1]
                        }
                    }
                }
            }
        }
    }
}

include(":app")
