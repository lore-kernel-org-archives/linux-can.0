From: Ico Doornekamp <ico@pruts.nl>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 May 2016 19:01:58 +0200
Message-ID: <1462986044-sup-1378@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <1462908218-sup-6526@pruts.nl> <5732E1F9.1060908@hartkopp.net> <1462952665-sup-1016@pruts.nl> <5732EA89.5060303@hartkopp.net> <1462969665-sup-623@pruts.nl> <573332DA.7070400@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:44998 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456AbcEKRCH (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 May 2016 13:02:07 -0400
In-reply-to: <573332DA.7070400@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

* On 2016-05-11 15:25:46 +0200, Oliver Hartkopp wrote:
 
> When my posted patch does not have an effect it may be worth looking at 
> the differences of the selected qdiscs (noqueue/pfifo).

No difference with the patch, I'll look into the qdiscs

> Hm - no.

Sorry, my wrong - I missed the part where you said 'I forgot slcan.c', and just
took a look at the patch in the link.

-- 
:wq
^X^Cy^K^X^C^C^C^C
