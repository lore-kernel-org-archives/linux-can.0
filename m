From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: RFC: (optional) software filtering in candump
Date: Wed, 19 Jun 2013 18:59:33 +0200
Message-ID: <51C1E375.3050600@hartkopp.net>
References: <190D92B052C049F4B059DCFE8F841940@laptop2> <51BB5B80.9060109@hartkopp.net> <D1C57559EF7B4FA8A6C669A1BF05CFDB@laptop2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:61775 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835Ab3FSQ7f (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Jun 2013 12:59:35 -0400
In-Reply-To: <D1C57559EF7B4FA8A6C669A1BF05CFDB@laptop2>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Janusz Uzycki <janusz.uzycki@elproma.com.pl>
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>


>> Additional a hardware timestamp can be retrieved from the hardware and passed
>> to the userspace. (HW timestamps)
> 
> Thanks Oliver for the explanation. It's clean now.
> Shouldn't hardware timestamping option be implemented like PTP?
> http://lxr.linux.no/linux+v3.9.6/net/core/timestamping.c#L104  (I don't need
> it but I couldn't find HW timestamp code for SJA1000 or MCP2515)

Yes, that's missing.

AFAIK only the PCAN USB (Pro) supports to pass the hardware timestamps to the
userspace. But when i took a quick look into the output, i wasn't able to
retrieve the HW timestamps.

I wrote a fix for the driver:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/net/can/usb/peak_usb/pcan_usb.c?id=c9faaa09e2a1335678f09c70a0d0eda095564bab

But i didn't manage to verify the HW timestamp output.

It's on my list of things i wanted to investigate when i'm bored ;-)

Regards,
Oliver


