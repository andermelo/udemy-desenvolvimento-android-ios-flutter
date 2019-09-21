# Uber

Projeto Uber clone, desenvolvido durante curso da Udemy

## Configurações

criando chaves para o Firebase no meu PC com Windows

Entrar em `C:\Program Files\Java\jre1.8.0_221\bin`

Comando: `keytool -list -v -alias androiddebugkey -keystore c:\Users\ander\.android\debug.keystore`

Senha: `android` - padrão Android

#### Correção do erro em AndroidX

(Como migrar para o AndroidX)[https://developer.android.com/jetpack/androidx/migrate]

`android/gradle.properties`

```
android.useAndroidX=true
    android.enableJetifier=true
```

`android/app/build.gradle`

```
android {
    ...

    defaultConfig {
        ...
        multiDexEnabled true
        
    }

    ...
}
```

### Resolvendo outro problema de AndroidX

> Eu resolvi atualizando minha dependência do gradle no arquivo android/build.gradle: classpath 'com.android.tools.build:gradle:3.3.1' (estava anteriormente na versão 3.2.1)


## Recursos utilizados
  * [AndroidX](https://developer.android.com/jetpack/androidx/migrate) 
  * [MultiDex](https://developer.android.com/studio/build/multidex?hl=pt-BR)
  * [Certificado SHA1](https://developers.google.com/android/guides/client-auth)
  * [Adicionar o Firebase ao projeto para Android](https://firebase.google.com/docs/android/setup?authuser=0)
  * [regras de segurança do Cloud Firestore](https://firebase.google.com/docs/firestore/security/get-started?authuser=0)
  * [firebase_core](https://pub.dev/packages/firebase_core)
  * [firebase_auth](https://pub.dev/packages/firebase_auth) 
  * [cloud_firestore](https://pub.dev/packages/cloud_firestore)
  * [google_maps_flutter](https://pub.dev/packages/google_maps_flutter)
  * [Google Cloud](https://console.cloud.google.com)

 



