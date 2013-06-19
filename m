From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: slcanpty
Date: Wed, 19 Jun 2013 19:15:54 +0200
Message-ID: <51C1E74A.70107@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2> <51B0D58F.2010401@hartkopp.net> <b4ff288352031c6f215c601575e7be0d@beep.pl> <51B7896D.7080608@hartkopp.net> <a1ef1ba453a6dca8222147aab20b61f1@beep.pl> <51B892E4.6020907@hartkopp.net> mid:1927 <3dc287504f468fde2629107bdc65c4ae@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:35866 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934942Ab3FSRP5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Jun 2013 13:15:57 -0400
In-Reply-To: <3dc287504f468fde2629107bdc65c4ae@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: j.uzycki@elproma.com.pl
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

On 18.06.2013 10:24, j.uzycki@elproma.com.pl wrote:

>> BTW:
>> I've learnt about HW filters in SJA1000. I compared the datasheet
>> with acceptance filter explanation here
>> http://www.can232.com/?page_id=72
>> According to datasheet's figures filter output bit acceptance is
>> (AMRn | (input ^ ACCn)) and according to the tables in explanation
>> acceptance is (AMRn | !(input ^ ACCn)). Do you have experience in
>> practive about it?
>> I want to convert SJA1000 filter to SocetCAN. SJA1000 has several
>> difficult features: dual filter (problem with overlapped filters -
>> additional checking required), data filter for 1st and/or 2nd data
>> byte (BCM mode supports, RAW mode requires userland filtering but ok).
>> Finally I consider it is better to use socketCAN filters or implement
>> the whole well defined filter (not universal like socketcan filter) in
>> userland. What could be more CPU effective?
> 
> I've just implemented SJA1000 filter emulator. I didn't test it yet. What do
> you think about the idea?

Pretty funny.

Your referenced docs (and your patch) are very informative, but I just wonder
if the filters have really ever been used by anybody.

They look *very* special.

If there's a need to implement it, it's ok.
But IMHO adding the filters just for the completeness of an emulation can be
omitted when nobody is ever using it.

Best regards,
Oliver

