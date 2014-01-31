From: Francesco Giovannini <Francesco.Giovannini@iit.it>
Subject: RE: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 17:38:37 +0000
Message-ID: <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de>
 <52EBD794.3020503@iit.it>
 <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.iit.it ([90.147.26.161]:18086 "EHLO es400ra01.iit.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932572AbaAaRij convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 31 Jan 2014 12:38:39 -0500
Received: from es400ra01.iit.it (127.0.0.1) id htffpu0171sg for <linux-can@vger.kernel.org>; Fri, 31 Jan 2014 18:38:38 +0100 (envelope-from <prvs=1108748f8e=Francesco.Giovannini@iit.it>)
In-Reply-To: <52EBDD1D.4060503@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Here is the output:

oSuseBox-IIT:/home/fgiovannini # dmesg -c > /dev/null

oSuseBox-IIT:/home/fgiovannini # canconfig can0 bitrate 1000000
can0 bitrate: 1000000, sample-point: 0.750

oSuseBox-IIT:/home/fgiovannini # canconfig can0
can0 bitrate: 0, sample-point: 0.000
can0 bittiming:
	tq: 0, prop-seq: 0 phase-seq1: 0 phase-seq2: 0 sjw: 0, brp: 0
can0 state: STOPPED
can0 restart-ms: 0
can0 ctrlmode: loopback[OFF], listen-only[OFF], tripple-sampling[OFF],one-shot[OFF], berr-reporting[OFF]
can0 clock freq: 60000000
can0 bittiming-constants: name esd_usb2,
	tseg1-min: 1, tseg1-max: 16, tseg2-min: 1, tseg2-max: 8,
	sjw-max 4, brp-min: 1, brp-max: 1024, brp-inc: 1,

oSuseBox-IIT:/home/fgiovannini # dmesg
[ 1189.194292] esd_usb2 1-10:1.0: can0: setting BTR=0x804d0002
[ 1189.195338] usb 1-10: USB disconnect, device number 7
[ 1189.432021] usb 1-10: new high-speed USB device number 8 using ehci_hcd
[ 1189.547438] usb 1-10: New USB device found, idVendor=0ab4, idProduct=0010
[ 1189.547442] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1189.547445] usb 1-10: Product: USB2292
[ 1189.547447] usb 1-10: Manufacturer: esd electronic system design gmbh (www.esd-electronics.com)
[ 1189.547450] usb 1-10: SerialNumber: GM001950
[ 1189.549832] esd_usb2 1-10:1.0: can0: device can0 registered


Weird. Looks like canconfig bitrate acts like it is unplugging and plugging the device. Is this normal?

--
Francesco Giovannini
Research Fellow
iCub Facility
Istituto Italiano di Tecnologia
Via Morego, 30 16163 Genova
email: francesco.giovannini@iit.it



________________________________________
From: Marc Kleine-Budde [mkl@pengutronix.de]
Sent: Friday, January 31, 2014 6:27 PM
To: Francesco Giovannini
Cc: linux-can@vger.kernel.org
Subject: Re: Can't start ESD CAN-USB/2

On 01/31/2014 06:26 PM, Marc Kleine-Budde wrote:
> On 01/31/2014 06:04 PM, Francesco Giovannini wrote:
>> I tried #canconfig can0 bitrate 1000000
>>
>>    can0 bitrate: 1000000, sample-point: 0.750
>>
>> I am however still unable to successfully start the can0 interface with
>> # ifconfig can0 up. Same error shows up.
>
> What's the outout of "canconfig can0" after "canconfig can0 bitrate 1000000"

Please try as root and send me the output:

    dmesg -c > /dev/null
    canconfig can0 bitrate 1000000
    canconfig can0
    dmesg

Marc

--
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

