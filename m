From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: SocketCAN support in Android: userspace headers
Date: Mon, 19 Mar 2012 17:12:00 +0100
Message-ID: <20120319161200.GA9978@vandijck-laurijssen.be>
References: <4F4B4C47.4060601@visionsystems.de>
 <4F6743A5.8050505@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:44918 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030655Ab2CSQME (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Mar 2012 12:12:04 -0400
Content-Disposition: inline
In-Reply-To: <4F6743A5.8050505@visionsystems.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

On Mon, Mar 19, 2012 at 03:33:09PM +0100, Yegor Yefremov wrote:
> Am 27.02.2012 10:26, schrieb Yegor Yefremov:

> what headers are necessary/usable for userspace? linux/can.h, linux/can/raw.h - what else? 
I believe the necessary headers should be installed by "$ make headers_install"

In case this command does not satisfy your build process, you can
do things manually after looking in include/linux/can/Kbuild, I think.

Kurt
