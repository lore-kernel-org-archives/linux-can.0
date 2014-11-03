From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/7] can: m_can: fix possible sleep in napi poll
Date: Mon, 03 Nov 2014 19:37:31 +0100
Message-ID: <5457CB6B.3080002@hartkopp.net>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com> <5457B517.8030805@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:32876 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbaKCShi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Nov 2014 13:37:38 -0500
In-Reply-To: <5457B517.8030805@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, varkabhadram@gmail.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Marc,

you can omit the 'stable' tag as this driver just emerged in 3.18 - which is
currently in 3.18-rc3 state.

If possible I would suggest to push all 7 patches via can/master as it is
pretty bad to say "M_CAN was introduced in 3.18 but M_CAN with CAN FD is
working since 3.19".

This will produce confusion as the M_CAN core has built-in CAN FD support.

Regards,
Oliver

On 11/03/2014 06:02 PM, Marc Kleine-Budde wrote:
> Hey Dong Aisheng,
> 
> the state of the patches are:
> 
> 1: can/master + stable
> 2: can/mster
> 3: can/mster
> 4: can/master + stable
> 5: waiting for Oliver's opinion due to the user space change
> 6: waiting for your input
> 7: waiting for your input
> 
> Marc
> 
