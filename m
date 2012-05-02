From: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Subject: Support of MCP2515 and AM35x High-End CAN controller in (RT-)SocketCAN
Date: Wed, 2 May 2012 16:51:15 +0900
Message-ID: <CAKG=6c4wMX4ZWFKAxN81-Rnf07wG1vqL96q0e78oe+VjsLSNrA@mail.gmail.com>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46308 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab2EBHvQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 May 2012 03:51:16 -0400
Received: by obbtb18 with SMTP id tb18so625412obb.19
        for <linux-can@vger.kernel.org>; Wed, 02 May 2012 00:51:16 -0700 (PDT)
In-Reply-To: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi everybody!

Looking for a low-cost solution for a real-time Linux system with CAN
bus support, I am currently considering the Beaglebone [1] (similar to
the Beagleboard) with the addition of a CAN bus cape [2]. The later
provides two MCP2515 CAN controller and also allows the use of the
integrated CAN controller [3] of the Beaglebone's ARM microprocessor
(Cortex A8) .

I am thinking about using a Linux kernel plus the RT-patch
(CONFIG_PREEMPT_RT), since it seems to be less work then setting up
Xenomai and the MCP2515 is already supported by SocketCAN. However, I
am not sure, if this set-up will satisfy our real-time constraints,
since SocketCAN is not real-time safe. Furthermore, I couldn't find
information about working solutions of patched Linux kernels on the
Beaglebord besides this paper [4].
Hence, I am also looking into the option of using Xenomai on the
Beaglebone for which I found working examples, such as [4]. However,
according to this list [5] the MCP2515 is not supported by
RTcan/RT-SocketCAN. Is this still true?

=46urthermore, is there support for the integrated CAN controller (AM35=
x
HECC) in SocketCAN and/or RT-SocketCAN?


Best regards,
Marcus Liebhardt

PS: Due to the information about SocketCAN on Gitorious, I also signed
up on linux-can@vger.kernel.org. In which case should one use that
list?
-> This questions got answered the auto-reply from
socketcan-users-bounces@lists.berlios.de (berlios mailing list is
deprecated). :-)

[1] http://beagleboard.org/bone
[2] http://www.towertech.it/en/products/hardware/tt3201-can-cape/
[3] http://processors.wiki.ti.com/index.php/AM35x_High-End_CAN_Controll=
er_%28HECC%29
[4] http://veter-project.blogspot.com/2011/09/real-time-enough-about-pw=
ms-and-shaky.html
[5] http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/=
README

--
Dipl.-Ing. (M.Sc.) Marcus Liebhardt
Control Engineer
Yujin Robot
=C1=D6=BC=D2: =B4=EB=C7=D1=B9=CE=B1=B9 =BC=AD=BF=EF=BD=C3 =B1=DD=C3=B5=B1=
=B8 =B0=A1=BB=EA=B5=BF 345-30 =B3=B2=BC=BA=C7=C1=B6=F3=C0=DA #601, 153-=
023.
Address: Door #601, Namsung-Plaza, 345-30 Gasan-dong, Guemcheon-gu,
Seoul, 153-023, Republic of Korea
Website: http://www.yujinrobot.com
Email: marcus.liebhardt@yujinrobot.com
Phone: +82-2-2104-0435
