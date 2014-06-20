From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: linux-can ISOTP module
Date: Fri, 20 Jun 2014 21:08:09 +0200
Message-ID: <53A48699.6030605@hartkopp.net>
References: <loom.20140604T144601-350@post.gmane.org>	<538F6836.3060508@hartkopp.net>	<CAA7hF3w-W1E0E5M4Gkc=0aYB0NQPrOMJfLp-iSG8K8HJU-sdoA@mail.gmail.com>	<539043EA.6030001@artisandeveloppeur.fr>	<5390B575.7030506@hartkopp.net> <CAA7hF3xomuS-mDRQWmkC=D9YfbDPt+TwXKc7+ZFtUNwkg5cMdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:54553 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbaFTTIN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 Jun 2014 15:08:13 -0400
In-Reply-To: <CAA7hF3xomuS-mDRQWmkC=D9YfbDPt+TwXKc7+ZFtUNwkg5cMdQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: maxime@artisandeveloppeur.fr, linux-can@vger.kernel.org

Hello Laurent,

On 06.06.2014 08:42, laurent vaudoit wrote:

>>>> With this method, how can i have a segmented transfer like this:
>>>> 0x6a7  0x55 0x10 0x08 ........
>>>> 0x687  0xAA 0x30 0x00 0x00
>>>> 0x6a7  0x55 0x21 .....
>>>>
>>>> The connection i need is between two ECU, using IDs 0x6a7/687 and one has
>>>> adress extension 0x55, the other 0xAA (this adressing method is used on some
>>>> FIAT ECUs for example), but i don't see how it can work using two socket.
>>> I confirm.
>>> This is a problem that we also encountered on a BMW ECU with the current
>>> implementation of ISOTP.
>>> The use-case is real and not currently supported.

I added the funtionality of a different rx_ext_addr to a specific branch of
can-utils and can-modules:

https://gitorious.org/linux-can/can-utils/commits/rx_ext_addr
https://gitorious.org/linux-can/can-modules/commits/rx_ext_addr

Please check them out for a test. As all the isotp tools (in the branch)
support the new feature too, it should be easy to do.

> In my opinion, it would be better to have all normalization parameters
> in the structure:
> __u8 Adressing_method
> __u8 TA
> __u8 SA
> __u8 AE
> 
> Because depending on the Adressing method used, you have to use TA
> (target adress) and SA (Source Adress) for first byte of the frame (TA
> in emission, SA in reception) or AE (adress extension) for both
> emission and reception (case of mixed adressing, see ISO15765-2
> normalization)
> But i don't know if it is available, due to compatibility.

I wonder whether this should be part of a syscall interface API.
The ISO15765-2 protocol is a CAN transport protocol which creates a virtual
point-to-point data connection with help of two CAN identifiers.
There are many use-cases for transport protocols besides diagnosis.

The fact that the ISO15765-2 appendix defines an assignment of logical
addresses to CAN identifiers does not mean that a socket API needs to provide
this assignment pattern. This can be done by some library too.

Regards,
Oliver

