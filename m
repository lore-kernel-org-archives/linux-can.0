From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH iproute2 v2 0/3] CAN Filter/Classifier
Date: Tue, 21 Aug 2012 08:27:50 +0200
Message-ID: <50332A66.80906@volkswagen.de>
References: <1343383363-6174-1-git-send-email-mkl@pengutronix.de> <20120820130605.63811eee@nehalam.linuxnetplumber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:57055 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2HUGeN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Aug 2012 02:34:13 -0400
In-Reply-To: <20120820130605.63811eee@nehalam.linuxnetplumber.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz, lisovy@gmail.com

No action required!

On 20.08.2012 22:06, Stephen Hemminger wrote:

>
> If your changes work with 3.6 then please rebase your patches on current iproute2 tree.
>
> Note: do not include changes to include/linux which now includes can.h
> and matches 3.6-rc2.
>


Both updates (can.h and em_canid.c) have been applied properly, see:

http://git.kernel.org/?p=linux/kernel/git/shemminger/iproute2.git;a=summary

Regards,
Oliver
