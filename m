From: Sebastian Haas <dev@sebastianhaas.info>
Subject: RxFilter issues vcan
Date: Wed, 29 May 2013 22:55:49 +0200
Message-ID: <51A66B55.6080506@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:38386 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966990Ab3E2VCO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 May 2013 17:02:14 -0400
Received: from [188.110.189.218] (helo=[192.168.2.106])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <dev@sebastianhaas.info>)
	id 1UhnPR-0000dm-G8
	for linux-can@vger.kernel.org; Wed, 29 May 2013 22:55:49 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can Mailing List <linux-can@vger.kernel.org>

Hello everybody,

I played a bit with the RxFilters and noticed that they are behaving 
somewhat strange.

If I start candump this way:
sh@helios:~/workspace/node-can$ candump vcan0,100~7ff,101~7ff
  I want to receive any messages except 100h and 101h.

When I send a message which matches the filter, it is received twice:
sh@helios:~/workspace/node-can$ cansend vcan0 1ff#22
   vcan0  1FF   [1]  22
   vcan0  1FF   [1]  22

When I send a message which should not received at all, it is received:
sh@helios:~/workspace/node-can$ cansend vcan0 100#22
   vcan0  100   [1]  22

Did I misunderstood the filter here?

Cheers,
Sebastian
