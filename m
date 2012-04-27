From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: SocketCAN version numbering
Date: Fri, 27 Apr 2012 11:43:03 +0200
Message-ID: <4F9A6A27.6040403@volkswagen.de>
References: <201204271125.43138.oe@port.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:43711 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab2D0Jsz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Apr 2012 05:48:55 -0400
In-Reply-To: <201204271125.43138.oe@port.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-15?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: linux-can@vger.kernel.org

On 27.04.2012 11:25, Heinz-J=FCrgen Oertel wrote:

> What is the suggested way to get the SocketCAN version number?
> On my two systems, according to Documentation/networking/can.txt, I a=
lways get
>
>   $ cat /proc/net/can/version
>   rev 20090105 abi 8
>
> on different systems.
> But one has support for error counters the other not with the same in=
terface board

Hello Heinz,

the version number is intended for the network layer stuff located in
linux/net/can and not for the CAN drivers.

Generally the version number is obsolete as it is part of the Kernel an=
d
therefore e.g. the ABI for applications has to be stable and backwards
compatible.

Btw. i think when adding support for CAN FD we should indicate that wit=
h a
new version number and ABI version 9.

When there are new functionalities that are implemented in a specific K=
ernel
version, you may use the uname() function to retrieve the Kernel versio=
n.

http://www.kernel.org/doc/man-pages/online/pages/man2/uname.2.html

Or check if a new function is known or not.

Regards,
Oliver
