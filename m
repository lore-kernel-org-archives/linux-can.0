From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] candump: Add possibility to specify logfile
Date: Wed, 21 Aug 2013 18:58:19 +0200
Message-ID: <5214F1AB.30404@hartkopp.net>
References: <52147A71.2080200@pengutronix.de> <1377076868-31679-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:41190 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3HUQ6W (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 12:58:22 -0400
In-Reply-To: <1377076868-31679-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org

On 21.08.2013 11:21, Alexander Stein wrote:
> You need to use -l/tmp/logfile (wihtout space!) because -l takes an
> optional parameter.
> 

Hm. I don't like that because of the "(without space!)"

If the option could have been passed like all other options (with space), it
would have been ok. But not like this.

I know that this is a getopt problem ...

Btw. why can't you just use '-L' and redirect the output, e.g.

candump -L can0 > mylogfile.log

??

Regards,
Oliver


