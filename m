From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: socketCan build fails
Date: Thu, 23 Feb 2012 18:48:51 +0100
Message-ID: <4F467C03.2000607@hartkopp.net>
References: <4F4654F6.8010201@wegmannusa.com> <4F4675B7.4040605@hartkopp.net> <4F46784C.7070104@wegmannusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:27029 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441Ab2BWRs6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 12:48:58 -0500
In-Reply-To: <4F46784C.7070104@wegmannusa.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gabriel Manriquez <gmanriquez@wegmannusa.com>
Cc: linux-can@vger.kernel.org

On 23.02.2012 18:33, Gabriel Manriquez wrote:

> Hi Oliver,
> 
> I'm running kernel version 2.6.35.11.
> 
> I was just following the README file which says to compile kernel/<version>
> ... so since you're saying that I don't need to then can I just go ahead and
> compile the utilities and test programs?


Yep! :-)

> I'm trying to use socketcan in conjuction with can driver :
> peak-linux-driver-7.4 which I already installed.


Then you are done.

> At this point I just need to test communication to and from my CAN device via
> usb and I thought I needed the socketcan utiliites/test programs to do that.


Yes - using the can-utils is the easiest way to start with SocketCAN.

> The peak-linux-driver-7.4 driver comes with receive and transmit test
> utilities but they're not suitable for my type of driver install  "NETDEV"


That's right.

> I hope what I'm saying makes sense.  Otherwise please ask.


Yes. Everything makes sense.

You're on the right way :-)

Regards,
Oliver
