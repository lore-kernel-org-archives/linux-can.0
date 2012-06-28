From: Rostislav Lisovy <lisovy@gmail.com>
Subject: Re: [PATCH net-next] em_canid: Ematch rule to match CAN frames
 according to their CAN IDs
Date: Thu, 28 Jun 2012 17:35:28 +0200
Message-ID: <1340897728.6032.31.camel@lolumad>
References: <1340022131-7827-1-git-send-email-lisovy@gmail.com>
	 <4FEA169C.1070709@hartkopp.net>
	 <20120627093325.GB410@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44523 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2F1Pfy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 11:35:54 -0400
In-Reply-To: <20120627093325.GB410@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org, lartc@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz

On Wed, 2012-06-27 at 11:33 +0200, Kurt Van Dijck wrote: 
> Oliver, Rostislav,
> 
> I was just looking into this. I think the matching itself
> may be simplified by eliminating checks 'that have already been made'.

Thank you for your remarks, I have removed all of the unnecessary
CAN_EFF_MASK masking.

Regards;
Rostislav 

