From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Fri, 18 Jan 2013 20:47:18 +0100
Message-ID: <50F9A6C6.7040602@hartkopp.net>
References: <a510e42c40b7b068b63bdefd7d7fb290.squirrel@webmail.universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:62287 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202Ab3ARTrY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Jan 2013 14:47:24 -0500
In-Reply-To: <a510e42c40b7b068b63bdefd7d7fb290.squirrel@webmail.universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

On 18.01.2013 15:31, "Bernd Krumb=F6ck" wrote:


>> [ 5941.577933] peak_usb 2-1.4:1.0 can3: Rx urb aborted (-32)
>> [ 5941.743693] usb 2-1.2: USB disconnect, device number 11
>> [ 5941.744096] usb_8dev 2-1.2:1.0 can2: device disconnected
>> [ 5941.744121] usb_8dev 2-1.2:1.0 can2: sending command message fail=
ed [
> 5941.744124] usb_8dev 2-1.2:1.0 can2: couldn't stop device
>=20
> How did you do this test?
>=20


- plug in USB
- ip link set can2 type can bitrate 1000000 restart-ms 100
- ifconfig can2 up
- plug out USB

leads to

(..)

[  347.106542] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.106802] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.107057] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.107308] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.107541] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.107790] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.108049] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.108289] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.108539] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.108794] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.108939] usb 2-1.2: USB disconnect, device number 6
[  347.109022] usb_8dev 2-1.2:1.0 can2: Rx URB aborted (-32)
[  347.111677] usb_8dev 2-1.2:1.0 can2: device disconnected
[  347.111863] usb_8dev 2-1.2:1.0 can2: sending command message failed
[  347.111868] usb_8dev 2-1.2:1.0 can2: couldn't stop device

Regards,
Oliver
