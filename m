From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: N_Cs timing - was Re: linux-can ISOTP module
Date: Sat, 21 Jun 2014 13:18:02 +0200
Message-ID: <53A569EA.9030701@hartkopp.net>
References: <loom.20140604T144601-350@post.gmane.org>	<538F6836.3060508@hartkopp.net> <CAA7hF3w-W1E0E5M4Gkc=0aYB0NQPrOMJfLp-iSG8K8HJU-sdoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:46808 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbaFULSF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Jun 2014 07:18:05 -0400
In-Reply-To: <CAA7hF3w-W1E0E5M4Gkc=0aYB0NQPrOMJfLp-iSG8K8HJU-sdoA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>, linux-can@vger.kernel.org

Hi Laurent,

as the extended address specification for the rx path is discussed/answered
in another thread I changed the subject for the timing discussion ...

On 05.06.2014 09:16, laurent vaudoit wrote:

> 
> Ok, with isotp.h api, i understand that we can parameter block size, stmin,
> wftmax, transmission time (n_ax), padding.
> But how can i specify the timing n_CS (time between flow control reception
> and first consecutive frame)

N_Cs is defined by the received STmin.

Then the tx_gap time is calculated by tx_gap = N_As + N_Cs

https://gitorious.org/linux-can/can-modules/source/027899c01aa2482423376e1e9f2a5875c316303a:net/can/isotp.c#L324

Finally the timer for the tx job is started relatively with this value
which leads to the required gap between the FC reception and the first CF. 


> and the timing n_BS (time between first frame
> reception and flow control emission)? 

N_Bs = N_Br + N_Ar

N_Ar is defined by the frame transmission time (on the real CAN bus)
N_Br has no setting but only a performance requirement:

N_Br + N_Ar < 0.9 * N_Bs timeout

N_Bs timeout = 1000ms => N_Br + N_Ar < 900ms

So AFAICS there's no way to specify N_Br. It can be as small as possible.
Therefore N_Bs is at least N_Ar + some various time for the protocol machine. 

> In the same way, is it possible to
> specify according timeout (n_BR for flow control timeout reception, and n_CR
> for consecutive frame timeout reception)?

Due to the spec all these timeouts are defined to be 1000ms.
Or did I miss something here?

Regards,
Oliver

