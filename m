From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: 8devices problem on usb-3.0 host
Date: Tue, 18 Jun 2013 20:21:17 +0200
Message-ID: <51C0A51D.8010802@universalnet.at>
References: <51C0533D.5030502@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:53239 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932824Ab3FRSax (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 18 Jun 2013 14:30:53 -0400
In-Reply-To: <51C0533D.5030502@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Michael Olbrich <mol@pengutronix.de>

Am 2013-06-18 14:31, schrieb Marc Kleine-Budde:
> Hello Bernd,
>
> my college Michael is using the 8 devices usb dongle on an USB-3.0 host
> and it fails with:
>
>> [ 1686.609330] can: raw protocol (rev 20120528)
>> [ 3347.787587] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
>> [ 3347.788319] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
>> [ 3347.789050] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
...
>> [ 3347.897224] usb_8dev 3-1.2:1.0 can0: Rx URB aborted (-32)
>> [ 3347.897725] usb 3-1.2: USB disconnect, device number 8
>> [ 3347.898037] usb_8dev 3-1.2:1.0 can0: device disconnected
>> [ 3347.898058] usb_8dev 3-1.2:1.0 can0: sending command message failed
>> [ 3347.898062] usb_8dev 3-1.2:1.0 can0: couldn't stop device
>> [ 3354.974145] usb 1-2: new full-speed USB device number 5 using xhci_hcd
>> [ 3354.974366] usb 1-2: Device not responding to set address.
>> [ 3355.184387] usb 1-2: Device not responding to set address.
>> [ 3355.394243] usb 1-2: device not accepting address 5, error -71
>> [ 3355.514288] usb 1-2: new full-speed USB device number 6 using xhci_hcd
>> [ 3355.536209] usb 1-2: New USB device found, idVendor=0483, idProduct=1234
>> [ 3355.536216] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>> [ 3355.536220] usb 1-2: Product: USB2CAN converter
>> [ 3355.536224] usb 1-2: Manufacturer: edevices
>> [ 3355.536227] usb 1-2: SerialNumber: ED000210
>> [ 3356.635802] usb_8dev 1-2:1.0 can0: no command message answer
>> [ 3356.635811] usb_8dev 1-2:1.0 can0: can't get firmware version
>
> Then the driver oopes; I already have a patch for the oops, I'll send it
> around soon.
>
> Marc
>


Hello Marc!


My tests also failed. :-(

System:
Linux debian 3.2.0-4-amd64
Asus U3S6 PCIe x4
USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 03)


dmesg:
[87087.312019] usb 2-2: new full-speed USB device number 4 using xhci_hcd
[87087.312300] usb 2-2: Device not responding to set address.
[87087.516288] usb 2-2: Device not responding to set address.
[87087.720009] usb 2-2: device not accepting address 4, error -71
[87087.832025] usb 2-2: new full-speed USB device number 5 using xhci_hcd
[87087.877433] usb 2-2: New USB device found, idVendor=0483, idProduct=1234
[87087.877437] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[87087.877440] usb 2-2: Product: USB2CAN converter
[87087.877442] usb 2-2: Manufacturer: edevices
[87087.877444] usb 2-2: SerialNumber: ED000202
[87087.877704] xhci_hcd 0000:06:00.0: ERROR: unexpected command completion code 0x11.
[87087.877712] usb 2-2: can't set config #1, error -22


Maybe a firmware bug?
Any ideas are highly welcome...


Firmware:
https://github.com/krumboeck/usb2can_firmware


regards,
Bernd

