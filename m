From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: SocketCAN over Ethernet
Date: Thu, 03 Apr 2014 21:42:30 +0200
Message-ID: <533DB9A6.6030605@hartkopp.net>
References: <loom.20140403T134741-892@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:52968 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbaDCTmd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Apr 2014 15:42:33 -0400
In-Reply-To: <loom.20140403T134741-892@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Daniel_Bostr=F6m?= <daniel.bostrom@maximatecc.com>, linux-can@vger.kernel.org

Hello Daniel,

On 03.04.2014 13:52, Daniel Bostr=F6m wrote:

> Currently we are running Ubuntu in a virtual machine using=20
> VirtualBox on a Windows host. In Ubuntu we use SocketCAN and we would=
 like=20
> to continue to do so but instead of using real CAN hardware somehow s=
etup=20
> CAN communication over Ethernet to the Windows host.

Don't know if I understand you correctly:

Do you want the CAN interfaces to be attached to the Windows host and a=
ccess
these interfaces from Linux ... or the other way around?

Maybe a look at the JAVA tool Kayak (http://kayak.2codeornot2code.org/)=
 might
be interesting for you.

Kayak uses the socketcand (https://github.com/dschanoeh/socketcand/) wh=
ich
runs on Linux and provides the CAN interfaces via IP-sockets (to whatev=
er client).

Regards,
Oliver

