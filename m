From: Francesco Giovannini <francesco.giovannini@iit.it>
Subject: Re: Can't start ESD CAN-USB/2
Date: Fri, 31 Jan 2014 18:04:20 +0100
Message-ID: <52EBD794.3020503@iit.it>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.iit.it ([90.147.26.161]:20223 "EHLO es400ra01.iit.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453AbaAaRET (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 31 Jan 2014 12:04:19 -0500
Received: from es400ra01.iit.it (127.0.0.1) id htfbp60171sc for <linux-can@vger.kernel.org>; Fri, 31 Jan 2014 18:04:16 +0100 (envelope-from <prvs=1108748f8e=Francesco.Giovannini@iit.it>)
In-Reply-To: <52EBCBFA.2090205@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Mark,

I tried #canconfig can0 bitrate 1000000

    can0 bitrate: 1000000, sample-point: 0.750

I am however still unable to successfully start the can0 interface with 
# ifconfig can0 up. Same error shows up.


Francesco

On 31/01/14 17:14, Marc Kleine-Budde wrote:
> On 01/31/2014 05:09 PM, Francesco Giovannini wrote:
>> Hi guys!
>>
>> I am running OpenSuse 12.2, kernel 3.4.63-2.44-desktop. I downloaded and
>> installed libsocketcan v0.0.9 and canutils v4.0.6. I then compiled the
>> esd_can2 module and modprobed it correctly. When i plug in my CAN-USB/2
>> device i get the following from dmesg:
>>
>>     [186823.262021] usb 1-10: new high-speed USB device number 22 using
>>     ehci_hcd
>>     [186823.826031] usb 1-10: device not accepting address 22, error -71
>>     [186823.877025] hub 1-0:1.0: unable to enumerate USB device on port 10
>>     [186827.879018] usb 1-10: new high-speed USB device number 24 using
>>     ehci_hcd
>>     [186827.995429] usb 1-10: New USB device found, idVendor=0ab4,
>>     idProduct=0010
>>     [186827.995432] usb 1-10: New USB device strings: Mfr=1, Product=2,
>>     SerialNumber=3
>>     [186827.995435] usb 1-10: Product: USB2292
>>     [186827.995438] usb 1-10: Manufacturer: esd electronic system design
>>     gmbh (www.esd-electronics.com)
>>     [186827.995440] usb 1-10: SerialNumber: GM001950
>>     [186827.997824] esd_usb2 1-10:1.0: can0: device can0 registered
>>
>> The device appears to be correctly recognised and the can0 interface is
>> ready to be used. I then set the bitrate and several other paramters with:
>>
>>     # canconfig can0 bittiming  prop-seg 2 phase-seg1 12 phase-seg2 5
>>     sjw 1 brp 3 tq 50
>>
>>     can0 bittiming:
>>          tq: 50, prop-seq: 2 phase-seq1: 12 phase-seq2: 5 sjw: 1, brp: 3
>>     can0 bitrate: 1000000, sample-point: 0.750
> Try to set the bittiming with this command:
>
>      canconfig can0 bitrate 1000000
>
> Does this work?
>
> Marc
>

-- 
*Francesco Giovannini*
Research Fellow
iCub Facility
*Istituto Italiano di Tecnologia*
Via Morego, 30 16163 Genova
/email:/ francesco.giovannini@iit.it <mailto://francesco.giovannini@iit.it>
www.iit.it <http://www.iit.it>

iit-logo-icub
