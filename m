From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: Web GUI for can-utils (i.e. cangw, cansend, candump)
Date: Mon, 10 Jun 2013 20:22:56 +0200
Message-ID: <51B61980.5060302@hartkopp.net>
References: <zarafa.51b5ff24.7028.506b738f3f6d3b02@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:11827 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab3FJSW7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 14:22:59 -0400
In-Reply-To: <zarafa.51b5ff24.7028.506b738f3f6d3b02@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 10.06.2013 18:30, Michael Luxen wrote:

> Thnak you for pointing me to the interestin toolchain with .kcd files (CANbabel translator), socketcand and Kayak.
> Nevertheless I did some tests last weekend on my BeagleBone Black setup with DCAN0/DCAN1.
> 
> If I fire round about 37%@500kbit/s to DCAN0 I get a tast load of round about 45% of socketcand. In general it's possible for me to use Kayak on i.e. my Windows machine and connect to my BeagleBone Black via ethernet. But if I use the second CAN channel (DCAN1) or increase the busload of channel one (DCAN0) the taskload/CPUload increases unacceptable.
> 
> Did you have the same experience with socketcand and Kayak?

Usually we use it with localhost IP communication.
An in the rare cases we use a MPC5200@400MHz based embedded system with two
CAN interfaces without any problems so far.

> Why isn't it possible to connect directly to the can0/can1 socketcan interfaces without socketcand?

Kayak is Java based. And Java does not support PF_CAN sockets. Therefore the
workaround via IP networking was necessary.

Best regards,
Oliver

