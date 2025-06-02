// /screens/CameraScreen.js
import React, { useRef, useState, useEffect } from 'react';
import { View, Button, StyleSheet } from 'react-native';
import { Camera } from 'expo-camera';

export default function CameraScreen({ navigation }) {
    const cameraRef = useRef(null);
    const [hasPermission, setHasPermission] = useState(null);

    useEffect(() => {
        (async () => {
            const { status } = await Camera.requestCameraPermissionsAsync();
            setHasPermission(status === 'granted');
        })();
    }, []);

    const takePicture = async () => {
        if (cameraRef.current) {
            const photo = await cameraRef.current.takePictureAsync({ base64: true });
            navigation.navigate('PreviewScreen', { photo }); // Envia a imagem para a próxima tela
        }
    };

    if (hasPermission === null) return <View />;
    if (hasPermission === false) return <Text>No access to camera</Text>;

    return (
        <Camera style={styles.camera} ref={cameraRef}>
            <View style={styles.buttonContainer}>
                <Button title="Tirar Foto" onPress={takePicture} />
            </View>
        </Camera>
    );
}

const styles = StyleSheet.create({
    camera: { flex: 1 },
    buttonContainer: {
        position: 'absolute',
        bottom: 30,
        alignSelf: 'center',
    },
});
