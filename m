From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: =?UTF-8?Q?PCH=5FCAN=20-=20echo=5Fskb=20is=20occupied?=
Date: Wed, 02 Apr 2014 09:45:37 +0000
Message-ID: <d0ce8e7491b6f3f71a428e30e07ec72f@grandegger.com>
References: <CA+vJB=yJ_tF1UwdwpLMVVYMKpTCQCYhWdFGGQNQNn2iP=1V3-A@mail.gmail.com>
 <533B138B.1010904@grandegger.com>
 <CA+vJB=xaTzCb3uzhRh5AOhsToiaqPZKRF9CSKG+FnSmR5hMw6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:45727 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758062AbaDBJpj (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 2 Apr 2014 05:45:39 -0400
In-Reply-To: <CA+vJB=xaTzCb3uzhRh5AOhsToiaqPZKRF9CSKG+FnSmR5hMw6w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: jprodriguez@elecnor.com
Cc: linux-can@vger.kernel.org

On Wed, 2 Apr 2014 10:35:24 +0200, JUAN PEDRO RODRIGUEZ NIETO
<jprodriguez@elecnor.com> wrote:
> Hello,
> 
> I am using Linux 3.10.11-yocto-standard kernel compiled using
> poky-dora-10.0.1
> 
> I didn't know about the C_CAN driver. What is the status of the C_CAN
> driver?
> I have found that in Kernel configuration/Networking support/CAN bus
> subsystem support/CAN device drivers there is a Generic PCI bus based
> C_CAN/D_CAN driver. I will try it.

Yes, but it needs to be extended for the PCH_CAN. Things like PCI device
and vendor ID, appropriate register access functions, reset handling,
etc. I'm going to send a patch later today or tomorrow.

Wolfgang.

