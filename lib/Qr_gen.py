import qrcode

# Data to be encoded
data = "https://youtu.be/2qCpY38ompo?si=YLI5RaylfsnOow6s"  # Replace this with your desired data

# Create a QR Code instance
qr = qrcode.QRCode(
    version=1,  # Controls the size of the QR code
    error_correction=qrcode.constants.ERROR_CORRECT_H,
    box_size=10,
    border=4,
)

# Add data to the QR code
qr.add_data(data)
qr.make(fit=True)

# Create an image from the QR Code instance
img = qr.make_image(fill_color="black", back_color="white")

# Save the image
img.save("qrcode.png")

print("QR code generated and saved as 'qrcode.png'")
