From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Peak PCAN USB question
Date: Wed, 25 Apr 2012 10:20:53 +0200
Message-ID: <4F97B3E5.3060603@grandegger.com>
References: <77D4E1B1D8549C4388FD52C58AC24547053FE38D@SBSPORT2.portnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:60843 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab2DYIUz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Apr 2012 04:20:55 -0400
In-Reply-To: <77D4E1B1D8549C4388FD52C58AC24547053FE38D@SBSPORT2.portnet.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 04/25/2012 09:37 AM, Heinz-J=FCrgen Oertel wrote:
> I'm working on a project where the application has to use can4linux a=
nd SocketCAN.
> Mainly because can4linux has no USB support yet.
> For some requests to the SocketCAN layer I use libsocketcan.
> Can someone confirm that can_get_berr_counter(), can_get_state()
> and may be some more functions are not working with the Peak PCAN USB=
 Interface?

Looking to the driver: can_get_berr_counter() is not supported but
can_get_state() should work. And bus error reporting is also not suppor=
ted.

Wolfgang.
