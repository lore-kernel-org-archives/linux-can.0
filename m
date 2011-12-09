From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: iproute2-j1939
Date: Fri, 09 Dec 2011 08:58:54 +0100
Message-ID: <4EE1BFBE.3080206@volkswagen.de>
References: <loom.20111206T131950-88@post.gmane.org> <20111206131815.GD322@e-circ.dyndns.org> <loom.20111207T093827-478@post.gmane.org> <20111207143333.GD373@e-circ.dyndns.org> <20111207145032.GE373@e-circ.dyndns.org> <loom.20111208T120006-91@post.gmane.org> <20111208123004.GA964@e-circ.dyndns.org> <loom.20111208T134455-791@post.gmane.org> <20111208133213.GB964@e-circ.dyndns.org> <loom.20111208T150123-262@post.gmane.org> <20111208151917.GE964@e-circ.dyndns.org> <loom.20111208T171058-366@post.gmane.org> <4EE1B0DE.3040607@volkswagen.de> <loom.20111209T082142-596@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:57831 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134Ab1LIH66 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Dec 2011 02:58:58 -0500
In-Reply-To: <loom.20111209T082142-596@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

Am 09.12.2011 08:28, schrieb Wolfgang:
> Morning,
>
>> What do you use for KERNEL_DIR=<..>  ??
>> Can you send the complete line?
>>
> I have build the BSP (which is supporting socketcan) some time ago;
>
> I make in ip2route-j1939:
>
> $ make KERNEL_DIR=</home/wolfgang/phytec/kernel/OSELAS.BSP-Phytec-\
> phyCORE-MPC512x-tiny-PD09.1.0/platform-phyCORE-MPC5121e/build-target\
> /linux-2.6.31>  CC=powerpc-603e-linux-gnu-gcc

Hm:

Try to remove the < > and/or try to define an extra define for the 
include path to catch

|
|.../build-target/linux-2.6.31/include

e.g. like in this EXTRA_CFLAGS

|EXTRA_CFLAGS += \
||         -I$(TOPDIR)/include \
||         -I$(TOPDIR)/drivers/net/can/hal \
||         \
||         -DETH_P_CAN=0x000C \
||         -DARPHRD_CAN=280|

Regards,
Oliver

