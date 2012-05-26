From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Strange error with jspy utility
Date: Sat, 26 May 2012 08:57:07 +0200
Message-ID: <4FC07EC3.3000406@hartkopp.net>
References: <CA+cPUuTWRQQ0qBnP1pE34wbMHF1OqXoBq5LkwQzkMgWFOyuzrA@mail.gmail.com> <4FB76279.6040201@hartkopp.net> <CA+cPUuTm72nWUcoK5QBEqZdKq9EjcSHcZrR1Z0s=pVV2gK25Ow@mail.gmail.com> <4FBEEB87.4060902@hartkopp.net> <CA+cPUuRwRE4A82AxL0LEOsPsKuu5XTR0wxcejhJMpOe3-ZpXPA@mail.gmail.com> <4FC0764D.5050900@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:19623 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab2EZG5I (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 26 May 2012 02:57:08 -0400
In-Reply-To: <4FC0764D.5050900@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Abdul Khan <akhan@symboticware.com>
Cc: linux-can@vger.kernel.org


>>
>> I don't know, Why sja1000_isa driver is giving "error warning
>> interrupt" and "error passive interrupt" messages. As simulator
>> supposed to be sent properly formatted j1939 frame to can1.
>>
>> What could be possible cause for this type of behaviour ?
>>


Is it possible, that when your j1939 simulator tries to answer, the problems
begin?

Regards,
Oliver

