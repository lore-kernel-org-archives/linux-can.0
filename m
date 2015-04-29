From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: kvaser leaf and SocketCAN
Date: Tue, 28 Apr 2015 20:50:18 -0700
Message-ID: <CANGgnMbtZz2M=-7ydV6iSFtCskTeXnKsWVB9rqnwX1M+SE1AAg@mail.gmail.com>
References: <loom.20150422T090300-352@post.gmane.org> <553755E8.20704@pengutronix.de>
 <loom.20150429T040002-878@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38376 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965853AbbD2Duk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 28 Apr 2015 23:50:40 -0400
Received: by wiun10 with SMTP id n10so51085263wiu.1
        for <linux-can@vger.kernel.org>; Tue, 28 Apr 2015 20:50:39 -0700 (PDT)
In-Reply-To: <loom.20150429T040002-878@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Leo Stan <leo.stanislas@qut.edu.au>
Cc: linux-can@vger.kernel.org

On Tue, Apr 28, 2015 at 7:01 PM, Leo Stan <leo.stanislas@qut.edu.au> wrote:
> When I connect the device I have the kernel log as follow
>
> [ 3506.638843] usb 1-3: USB disconnect, device number 6
> [ 3508.818400] usb 1-3: new high-speed USB device number 7 using xhci_hcd
> [ 3508.949596] usb 1-3: New USB device found, idVendor=0bfd, idProduct=0120
> [ 3508.949603] usb 1-3: New USB device strings: Mfr=0, Product=2,
> SerialNumber=0
> [ 3508.949607] usb 1-3: Product: Kvaser Leaf Light HS
>
> I have installed the drivers from Kvaser for linux therefore I have the
> modules :
>
> kvaser_usb             22385  0
> can_dev                21659  1 kvaser_usb
>
> However nothing appears in /dev folder
>
> I tried the SocketCan example code from this wiki page :
>
> http://en.wikipedia.org/wiki/SocketCAN
>
> But I get this error :
>
> vcan0 at index -571419056
> Error in socket bind: No such device

You won't see anything in /dev/ if socketcan is working correctly.
Try ifconfig -a to see the interface.  From one of my machines (with a
SJA1000 from Peak):

$ ifconfig -a
can0      Link encap:UNSPEC  HWaddr
00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00
          UP RUNNING NOARP  MTU:16  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:10
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:18

Austin
