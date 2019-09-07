import cv2


def predict(frame, net):
    # Prepare input blob and perform an inference
    blob = cv2.dnn.blobFromImage(frame, size=(300, 300), ddepth=cv2.CV_8U)
    net.setInput(blob)
    out = net.forward()

    predictions = []

    # The net outputs a blob with the shape: [1, 1, N, 7], where N is the number of detected bounding boxes.
    # For each detection, the description has the format: [image_id, label, conf, x_min, y_min, x_max, y_max]

    # Draw detected faces on the frame
    for detection in out.reshape(-1, 7):
        image_id, label, conf, x_min, y_min, x_max, y_max = detection

        if conf > 0.5:
            predictions.append(detection)

    # return the list of predictions to the calling function
    return predictions


# Load the model
net = cv2.dnn.readNet('face-detection-adas-0001.xml',
                      'face-detection-adas-0001.bin')

# Specify target device
net.setPreferableTarget(cv2.dnn.DNN_TARGET_MYRIAD)
cap = cv2.VideoCapture(0)

# Read an image
while cv2.waitKey(1) < 0:

	ret, frame = cap.read()
    frame = cv2.resize(frame,(300,300))
	predictions = predict(frame, net)

	# Draw detected faces on the frame
	for prediction in predictions:
		confidence = float(prediction[2])
		xmin = int(prediction[3] * frame.shape[1])
		ymin = int(prediction[4] * frame.shape[0])
		xmax = int(prediction[5] * frame.shape[1])
		ymax = int(prediction[6] * frame.shape[0])

		# cv2.rectangle(frame, (xmin, ymin), (xmax, ymax), color=(0, 255, 0))
        print(confidence)
	# Save the frame to an image file
	cv2.imshow('out.bmp', frame)
cv2.destroyAllWindows()
