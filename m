From: Rostislav Lisovy <lisovy@gmail.com>
Subject: Re: [PATCH net-next] em_canid: Ematch rule to match CAN frames
 according to their CAN IDs
Date: Thu, 28 Jun 2012 19:02:38 +0200
Message-ID: <1340902958.9286.1.camel@lolumad>
References: <1340022131-7827-1-git-send-email-lisovy@gmail.com>
	  <4FEA169C.1070709@hartkopp.net> <1340890522.6032.22.camel@lolumad>
	 <4FEC87E8.1030405@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50521 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903Ab2F1RCm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 13:02:42 -0400
In-Reply-To: <4FEC87E8.1030405@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, linux-can@vger.kernel.org, lartc@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz

On Thu, 2012-06-28 at 18:35 +0200, Oliver Hartkopp wrote:

> 
> What about 
> 
> 	match = (test_bit(can_id, cm->match_sff))?1:0;
> 
> and working with "1" and "0" all the time instead of the final correction to
> the return values at the end of the function?

I agree;

Regards;
Rostislav

