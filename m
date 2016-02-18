From: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Subject: Re: PCAN USB Pro FD one-shot
Date: Thu, 18 Feb 2016 14:39:53 +0100
Message-ID: <56C5C9A9.7030901@sevenbyte.org>
References: <56C5BF73.9040402@sevenbyte.org> <56C5C73D.5080304@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.sevenbyte.org ([5.9.90.188]:55703 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425461AbcBRNj5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 18 Feb 2016 08:39:57 -0500
In-Reply-To: <56C5C73D.5080304@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>, Stephane Grosjean <s.grosjean@peak-system.com>

On 18.02.2016 14:29, Marc Kleine-Budde wrote:
> Indeed it's not supported by the driver. Maybe Stephane can tell,
> if at least the hardware supports this feature.
> 
> Marc

I had emailed the support a while ago. The mode seems to be supported;
but they call it "single shot" instead. I assume it is the same as
"one-shot", see also [1].

Stefan

[1]:
http://www.peak-system.com/forum/viewtopic.php?f=120&t=1587&p=4725&hilit=single+shot#p4725
