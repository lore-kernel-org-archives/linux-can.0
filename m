From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: RFS: socketcan-utils
Date: Wed, 11 Apr 2012 18:17:44 +0200
Message-ID: <4F85AEA8.1000405@hartkopp.net>
References: <201105021707.01903.mab@comnets.uni-bremen.de> <201105310946.46575.mab@comnets.uni-bremen.de> <4DE5492A.4050008@hartkopp.net> <201204111509.18993.mab@comnets.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:45123 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760634Ab2DKQRn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Apr 2012 12:17:43 -0400
In-Reply-To: <201204111509.18993.mab@comnets.uni-bremen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Markus Becker <mab@comnets.uni-bremen.de>
Cc: linux-can@vger.kernel.org

On 11.04.2012 15:09, Markus Becker wrote:

>> On 31.05.2011 09:46, Markus Becker wrote:
>>>> On 30.05.2011 09:16, Markus Becker wrote:
>>>>> Well, we explicitly need isotp, which is not included in stock debian
>>>>> images. That's actually the reason for creating the images. Any idea of
>>>>> how to get Linux mainline isotp kernel module into the Debian kernel?
>>>>
>>>> My problem is, that we're using my isotp stuff for many purposes for
>>>> more than two years now. I'm not far from sending a patch on netdev-ML
>>>> - but i'm still missing some feedback from isotp-users (like you), if
>>>> they think the protocol and it's API are mature enough for mainline ...
>>>> is it?
>>>
>>> Within the next two month, we will test two telematic devices against
>>> socketCAN ISO-TP and raw or J1939 frames. The Debian packages were
>>> created to get our test equipment ready. Will report to you on our
>>> experience.
> 
> Well it took longer... But here comes the report on our experience with ISO-
> TP:
> 
> We tested successfully against two other proprietary ISO-TP CAN 
> implementations with isotpsend and isotprecv without any problems.


Hello Markus,

thanks for the feedback on the ISO-TP implementation.

Indeed we're also using it every day and i did not see any issues for a long
time now.

The missing thing is that you currently need to set the tx_queue_len of the
according network device to high values (like 1000) as the ISO-TP
implementation does not react on full tx queues 8-)

Regards,
Oliver
