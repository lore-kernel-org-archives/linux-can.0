From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/2] slcanpty: /dev/tty support for tests
Date: Tue, 11 Jun 2013 22:28:24 +0200
Message-ID: <51B78868.2090301@hartkopp.net>
References: <2DAB3DC2841347E7AF7833620339B427@laptop2> <51AF950D.1050004@hartkopp.net> <8BA0AB4D19CC422597E52513948E2EF0@laptop2> <51B0D58F.2010401@hartkopp.net> <6f9fdd56db06e6029218834c526f7d15@beep.pl> <51B310DC.8040509@hartkopp.net> <5dedc0b6441b754aebf3b560756932b8@beep.pl> <2b96a7606efb82e512f328eb2260b4bd@beep.pl> <f4dc05d8086417bb0b0b3613a0e93311@beep.pl> <a6a53837d3a628d0a188d974acfd2597@beep.pl> <5b163f3e26b882777deae9a0f3ba248c@beep.pl> <3bdf2623dd49f435018b29b60d720a3b@beep.pl> <51B61AF7.901@hartkopp.net> <f00a17de7fa15644f49ca035d77b1769@beep.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:22792 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307Ab3FKU22 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2013 16:28:28 -0400
In-Reply-To: <f00a17de7fa15644f49ca035d77b1769@beep.pl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: janusz.uzycki@elproma.com.pl
Cc: linux-can@vger.kernel.org, Krzysztof Borgulski <k.borgulski@elproma.com.pl>

On 10.06.2013 20:38, janusz.uzycki@elproma.com.pl wrote:
> ;)
> 
> * The first today fixes terminal settings (cr/nl). Flags update is enough for
> that.
> * 1/2 patch introduces stdin detection switch. It is important if you want to
> use slcanpty as deamon - natural choice for me.
> * 2/2 patch is rather for very simple testings using console (like DEBUG
> define). However command "slcanpty /dev/tty vcan0 < /dev/null" makes the patch
> redundant.
> So the first and 1/2 are really strongly suggested.

Ok, i applied these two fixes after some coding style rework.

Tnx & best regards,
Oliver


