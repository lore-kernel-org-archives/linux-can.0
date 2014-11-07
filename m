From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: candump error flags
Date: Fri, 7 Nov 2014 14:13:17 +0000
Message-ID: <20141107141317.GA11664@shannon>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:42208
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751971AbaKGONV (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 7 Nov 2014 09:13:21 -0500
Content-Disposition: inline
In-Reply-To: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>
Cc: linux-can@vger.kernel.org

On Fri, Nov 07, 2014 at 09:57:41AM -0400, Paul Lever wrote:
> I'm trying to use the candump -e and -d options to catch errors. I
> know that frames are being dropped, as I can see missing packets in
> known sequences, yet I never see anything printed from candump
> indicating any errors or dropped packets. Is there additional steps
> needed to get output from -e/-d options? This is on a Beaglebone Black
> platform.
> My cmd line is:
> candump -t a -e -d -r 16000 can0 > /media/testdata.raw&
>

Hi Paul,

Error handling is different between platforms. On some platforms you need to
enable berr-reporting to get errors. Some platforms support a limited set of
errors (or even no errors at all?)

You can grep for "CAN_ERR" in the driver for your platform to find out which
errors are implemented.

--
Cheers,
Andri

