From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: socket can receive order
Date: Wed, 09 Sep 2015 18:31:41 +0200
Message-ID: <55F05EED.1090302@hartkopp.net>
References: <55EEAD8D.3070603@engineeredarts.co.uk> <55EEB217.3080706@pengutronix.de> <55EEBB4E.6080104@engineeredarts.co.uk> <55EEC2BD.6010302@pengutronix.de> <55EEC3C0.1010002@engineeredarts.co.uk> <55EF133E.8070105@hartkopp.net> <CANGgnMZMRMtpugbN4x9Dh0v3i7zaAXRYfk+C1qhx1Nre=6WtEg@mail.gmail.com> <55F05AFE.8070203@engineeredarts.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:50604 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbbIIQbp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Sep 2015 12:31:45 -0400
In-Reply-To: <55F05AFE.8070203@engineeredarts.co.uk>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Daniel Squires <dan@engineeredarts.co.uk>, Austin Schuh <austin@peloton-tech.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 09.09.2015 18:14, Daniel Squires wrote:
> The Hack seems to work, its been a short test of a half hour so far, but
> before it happened reliably after a few seconds.

Great! You should not see any out-of-order frames anymore.

I obviously have to start a new attempt to push that single line of source 
code into mainline :-)

If it doesn't help to fix your latency problem under ethernet load, you might 
check the fixed irq_affinity setting for separating ethernet/CAN CPUs that 
Brian and Austin were suggesting.

Thanks for the feedback,
Oliver

