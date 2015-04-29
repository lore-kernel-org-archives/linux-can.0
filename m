From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: kvaser leaf and SocketCAN
Date: Wed, 29 Apr 2015 08:33:26 +0200
Message-ID: <1489880.T5xsN7s51f@ws-stein>
References: <loom.20150422T090300-352@post.gmane.org> <55406A03.9060105@pengutronix.de> <loom.20150429T081022-13@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:33634 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753503AbbD2Gd6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Apr 2015 02:33:58 -0400
In-Reply-To: <loom.20150429T081022-13@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Leo Stan <leo.stanislas@qut.edu.au>
Cc: linux-can@vger.kernel.org

Hi Leo,

On Wednesday 29 April 2015 06:15:53, Leo Stan wrote:
> - ifconfig -a shows the CAN :
> 
> can0      Link encap:UNSPEC  HWaddr 00-00-00-00-00-00-00-00-00-00-00-00-00-

  ^^^^

Compare this with...

> 00-00-00  
>           NOARP  MTU:16  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:10 
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> 
> - My kernel log shows :
> 
> usb 1-3: new high-speed USB device number 4 using xhci_hcd
> [ 1393.767114] usb 1-3: New USB device found, idVendor=0bfd, idProduct=0120
> [ 1393.767124] usb 1-3: New USB device strings: Mfr=0, Product=2, 
> SerialNumber=0
> [ 1393.767128] usb 1-3: Product: Kvaser Leaf Light HS
> [ 1393.815801] CAN device driver interface
> [ 1393.857896] usbcore: registered new interface driver kvaser_usb
> 
> - When I try to run the example from http://en.wikipedia.org/wiki/SocketCAN I get this error :
> 
> vcan0 at index 1866752400
  ^^^^^

...this. Notice the difference?
You also might want to use https://github.com/linux-can/can-utils/

HTH
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

