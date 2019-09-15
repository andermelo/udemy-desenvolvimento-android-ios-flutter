# firebase

Projeto de estudo com o Firebase e Flutter

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

## Selecionando imagens - câmera & galeria de fotos

### Recursos

 * [image_picker](https://pub.dev/packages/image_picker) 

## Recursos utilizados
 * [firebase_core](https://pub.dev/packages/firebase_core)
 * [cloud_firestore](https://pub.dev/packages/cloud_firestore)
 * [firebase_storage](https://pub.dev/packages/firebase_storage)
 * [firebase_auth](https://pub.dev/packages/firebase_auth)
 * [Correção no erro AndroidX](https://developer.android.com/jetpack/androidx/migrate)



