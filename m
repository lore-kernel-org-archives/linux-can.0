From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: Initialisation issue with powered USB 2.0 hub
Date: Mon, 16 Feb 2015 07:36:58 +0100
Message-ID: <54E1900A.4050702@hartkopp.net>
References: <54D3B071.4040705@hartkopp.net> <54D90ADB.8020700@universalnet.at> <54D90CA7.50302@hartkopp.net> <54DF04A3.1010602@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:25050 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbbBPGhJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Feb 2015 01:37:09 -0500
In-Reply-To: <54DF04A3.1010602@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>, Gediminas Simanskis <gediminas@8devices.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Bernd,

On 14.02.2015 09:17, Bernd Krumboeck wrote:
> I was able to reconstruct, but I think it is not a driver problem (at least
> not only).

I assume it's easier to fix this in the firmware for the end-user.
I'll last a long time until the patches will get into Linux 3.9+ - some are 
not even supported anymore.

@Gediminas: Can you confirm this issue with the Windows driver too?

@Bernd: When resetting the device is an usual handling e.g. by other USB 
drivers it makes sens to add this functionality too. If not we should just 
wait for the firmware fix.

Best regards,
Oliver

>
> Tested hard- and software:
> Wiregate (ALIX 1E Board) with Conrad selfpowered USB hub.
> Kernel 3.5.1 with latest driver from pre-3.3 branch.
>
> Links for Details:
> http://www.pcengines.ch/alix1e.htm
> http://www.conrad.at/ce/de/product/971592/7-Port-USB-20-Hub-Metallgehaeuse-zur-Wandmontage-CE-Schwarz?ref=searchDetail
>
>
>
>
> Steps of my test:
> 1) Disconnnect USB hub from System:
>     System removed the network interface (expected behavior)
>
> 2) Reconnect USB Hub to System:
>     LED is still green. Startup device again. Everything looks normal, except
> we don't receive CAN messages.
>     Sending messages was not tested, because of missing test environment.
>
> 3) Rebooted the System:
>     LED is still green. Everything looks normal, except we don't receive CAN
> messages.
>
> 4) Unbind USB device (echo "1-4.1.2" > /sys/bus/usb/drivers/usb/unbind):
>     Unbind worked as expected: LED becomes red.
>     Following message appears in the kernel log:
>     [  356.897524] usb_8dev 1-4.1.2:1.0: can0: device disconnected
>
> 5) Bind USB device (echo "1-4.1.2" > /sys/bus/usb/drivers/usb/bind):
>     LED stays red. This is not an expected behavior.
>     Following message appears in the kernel log:
>     [  392.584273] usb_8dev 1-4.1.2:1.0: can0: no command message answer
>     [  392.584427] usb_8dev 1-4.1.2:1.0: can0: can't get firmware version
>     [  392.585276] usb_8dev: probe of 1-4.1.2:1.0 failed with error -110
>
>     I often use this rebind procedure for hanging (unresponsive) Huawai 3G
> sticks. First time this does not work.
>
> 6) Disconnect USB2CAN adapter from hub. Reconnect the adapter:
>     LED becomes green. Everything works as expected.
>
>
> Conclusion:
> At this time I assume it is a firmware issue. At least the rebind procedure
> should work, if everything else didn't.
>
>
> Not tested workaround:
> Probably it helps to send a reset command in the driver before startup, but I
> didn't test.
>
>
> PS: I had some kernel crashes with "Intel Corporation 82801I (ICH9 Family)"
> usb controller.
>
>
> regards,
> Bernd
>
>
>
>
> Am 2015-02-09 um 20:38 schrieb Oliver Hartkopp:
>> Hi Bernd,
>>
>> On 09.02.2015 20:30, Bernd Krumboeck wrote:
>>
>>> I will try to test, when I have some time (in about two weeks).
>>
>> I'm looking forward to it ...
>>
>>> The kernel crash should not happen with newer kernel/driver versions.
>>> So I'll ignore until I get an exact version number.
>>
>> Ok. I'll ask the colleague and check the patch status of his kernel.
>>
>> Thanks,
>> Oliver
>>
>>>
>>>
>>>
>>> Am 2015-02-05 um 19:03 schrieb Oliver Hartkopp:
>>>> Hi Bernd,
>>>>
>>>> i got an error report from a colleague today who is using the USB2CAN from
>>>> 8devices behind a self powered USB2.0 hub.
>>>>
>>>> The way to get into the problem:
>>>>
>>>> 1. Connect a self powered USB hub with attached USB2CAN to the host:
>>>>
>>>>
>>>> [  502.464008] usb 3-2: new high-speed USB device number 8 using xhci_hcd
>>>> [  502.593336] usb 3-2: New USB device found, idVendor=05e3, idProduct=0608
>>>> [  502.593339] usb 3-2: New USB device strings: Mfr=0, Product=1,
>>>> SerialNumber=0
>>>> [  502.593341] usb 3-2: Product: USB2.0 Hub
>>>> [  502.593863] hub 3-2:1.0: USB hub found
>>>> [  502.594124] hub 3-2:1.0: 4 ports detected
>>>> [  502.864710] usb 3-2.1: new full-speed USB device number 9 using xhci_hcd
>>>> [  502.955087] usb 3-2.1: New USB device found, idVendor=0483, idProduct=1234
>>>> [  502.955097] usb 3-2.1: New USB device strings: Mfr=1, Product=2,
>>>> SerialNumber=3
>>>> [  502.955102] usb 3-2.1: Product: USB2CAN converter
>>>> [  502.955106] usb 3-2.1: Manufacturer: edevices
>>>> [  502.955110] usb 3-2.1: SerialNumber: ED000215
>>>> [  502.956739] usb_8dev 3-2.1:1.0 can0: firmware: 1.5, hardware: 255.255
>>>>
>>>> (everything is fine - USB2CAN LED is RED)
>>>>
>>>> # ip -det link show can0
>>>> 21: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group
>>>> default qlen 10
>>>>      link/can  promiscuity 0
>>>>      can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>>>>       usb_8dev: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>>>>       clock 32000000
>>>> # ip link set can0 type can bitrate 500000
>>>> # ifconfig can0 up
>>>>
>>>> (still everything is fine - USB2CAN LED is GREEN)
>>>>
>>>> Adapter works as expected. It can send and receive CAN frames.
>>>>
>>>> 2. Now unplug the powered hub from the PC:
>>>>
>>>> [  680.841130] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
>>>> [  680.841212] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
>>>> [  680.841252] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
>>>> [  680.841308] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
>>>> [  680.841352] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
>>>> [  680.841377] usb 3-2: USB disconnect, device number 8
>>>> [  680.841385] usb 3-2.1: USB disconnect, device number 9
>>>> [  680.841388] usb_8dev 3-2.1:1.0 can0: Rx URB aborted (-71)
>>>> [  680.843607] usb_8dev 3-2.1:1.0 can0: device disconnected
>>>> [  680.843634] usb_8dev 3-2.1:1.0 can0: sending command message failed
>>>> [  680.843639] usb_8dev 3-2.1:1.0 can0: couldn't stop device
>>>>
>>>> The USB2CAN LED remains GREEN - as the adapter is still powered.
>>>>
>>>> 3. Now plug the powered hub into the PC again:
>>>>
>>>> [  705.799101] usb 3-2: new high-speed USB device number 10 using xhci_hcd
>>>> [  705.928881] usb 3-2: New USB device found, idVendor=05e3, idProduct=0608
>>>> [  705.928891] usb 3-2: New USB device strings: Mfr=0, Product=1,
>>>> SerialNumber=0
>>>> [  705.928895] usb 3-2: Product: USB2.0 Hub
>>>> [  705.929871] hub 3-2:1.0: USB hub found
>>>> [  705.930191] hub 3-2:1.0: 4 ports detected
>>>> [  706.203831] usb 3-2.1: new full-speed USB device number 11 using xhci_hcd
>>>> [  706.294249] usb 3-2.1: New USB device found, idVendor=0483, idProduct=1234
>>>> [  706.294259] usb 3-2.1: New USB device strings: Mfr=1, Product=2,
>>>> SerialNumber=3
>>>> [  706.294264] usb 3-2.1: Product: USB2CAN converter
>>>> [  706.294268] usb 3-2.1: Manufacturer: edevices
>>>> [  706.294271] usb 3-2.1: SerialNumber: ED000215
>>>> [  706.296097] usb_8dev 3-2.1:1.0 can0: firmware: 1.5, hardware: 255.255
>>>>
>>>> The USB2CAN LED remains GREEN - as the adapter is still powered.
>>>> But the CAN netdevice is not configured:
>>>>
>>>> # ip -det link show can0
>>>> 21: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group
>>>> default qlen 10
>>>>      link/can  promiscuity 0
>>>>      can state STOPPED (berr-counter tx 0 rx 0) restart-ms 0
>>>>       usb_8dev: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..1024 brp-inc 1
>>>>       clock 32000000
>>>>
>>>> After setting the bitrate again & putting the interface up:
>>>>
>>>> # ip link set can0 type can bitrate 500000
>>>> # ifconfig can0 up
>>>>
>>>> The USB2CAN LED remains GREEN.
>>>>
>>>> But from this point the USB2CAN adapter can only *send* CAN frames but it
>>>> can not
>>>> receive any frames. Btw. the CAN controller inside the USB2CAN properly
>>>> acknowledges
>>>> the CAN frames on the bus (without making them visible on the host).
>>>>
>>>> Any idea how to fix the initialization in this warm start scenario?
>>>>
>>>> My colleague also reported kernel crashes which I wasn't able to reproduce.
>>>> I used a 3.19.0-rc7 here - don't know what my colleague was using.
>>>>
>>>> Best regards,
>>>> Oliver
>>>>
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
