From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: slcand in init.d-scripts
Date: Mon, 08 Jun 2015 12:41:20 +0200
Message-ID: <55757150.7020008@hartkopp.net>
References: <20150608101412.Horde.cpWZ5_FJEM-ciNcxvoY5Nkf@webmail.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:44990 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbbFHKld (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Jun 2015 06:41:33 -0400
In-Reply-To: <20150608101412.Horde.cpWZ5_FJEM-ciNcxvoY5Nkf@webmail.uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Armin Burchardt <armin@uni-bremen.de>, linux-can@vger.kernel.org

Hi Armin,

thanks for your contributions which are definitely useful!

Can you please sent 3 separate mails with the patch content in-line?

Usually 'git send-email' does this in a perfect manner.

Patches inside attachments can not be commented and discussed.

Please add some comments to patch 2 too.

Thanks & best regards,
Oliver


On 08.06.2015 12:14, Armin Burchardt wrote:
>
> Hello,
>
> to make init.d-scripts easier to write, I propose some changes to slcand:
> * write pidfile
> * set up-flag
> * do not daemonize too early
>
> Regards
> Armin
