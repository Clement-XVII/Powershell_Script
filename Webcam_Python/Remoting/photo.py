

import cv2
# Setup webcam camera
cap = cv2.VideoCapture(0)
# Set a smaller resolution
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
s, img = cap.read()
if s:
    # Capture frame-by-frame
    #cv2.imshow("cap-test",img)
    cv2.waitKey(0)
    cv2.imwrite("filename.jpg",img) #save image

    cv2.destroyAllWindows()

    """
    
    import cv2

cam = cv2.VideoCapture(0)
# Set a smaller resolution
cam.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
cam.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
s, img = cam.read()
if s:
    #cv2.namedWindow("cam-test",CV_WINDOW_AUTOSIZE)
    cv2.imshow("cam-test",img)
    cv2.waitKey(0)
    cv2.destroyWindow("cam-test")
    cv2.imwrite("filename.jpg",img) #save image
# When everything done, release the capture

    
    """