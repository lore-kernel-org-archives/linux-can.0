From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: Re: N_Cs timing - was Re: linux-can ISOTP module
Date: Mon, 23 Jun 2014 20:13:08 +0200
Message-ID: <CAA7hF3w6GQ1zCMxUfkqZWSSMwWNhwOYf-szkvdGj1qpB2cuuTQ@mail.gmail.com>
References: <loom.20140604T144601-350@post.gmane.org>
	<538F6836.3060508@hartkopp.net>
	<CAA7hF3w-W1E0E5M4Gkc=0aYB0NQPrOMJfLp-iSG8K8HJU-sdoA@mail.gmail.com>
	<53A569EA.9030701@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:65207 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628AbaFWSNJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jun 2014 14:13:09 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so6466702qcy.15
        for <linux-can@vger.kernel.org>; Mon, 23 Jun 2014 11:13:08 -0700 (PDT)
In-Reply-To: <53A569EA.9030701@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

Hi Oliver,

On Sat, Jun 21, 2014 at 1:18 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hi Laurent,
>
> as the extended address specification for the rx path is discussed/answered
> in another thread I changed the subject for the timing discussion ...

ok no problem, it will be more clear.
>
> On 05.06.2014 09:16, laurent vaudoit wrote:
>
>>
>> Ok, with isotp.h api, i understand that we can parameter block size, stmin,
>> wftmax, transmission time (n_ax), padding.
>> But how can i specify the timing n_CS (time between flow control reception
>> and first consecutive frame)
>
> N_Cs is defined by the received STmin.
>
> Then the tx_gap time is calculated by tx_gap = N_As + N_Cs
>
> https://gitorious.org/linux-can/can-modules/source/027899c01aa2482423376e1e9f2a5875c316303a:net/can/isotp.c#L324
>
> Finally the timer for the tx job is started relatively with this value
> which leads to the required gap between the FC reception and the first CF.
>
Yes i saw this in the code.
In my opinion, it should be two different timing, N_CS for emission of
the first Consecutive frame and then stmin given by ECU from flow
control.
After, this implementation will work in most of the case, but it is a
little  different from iso15765-2.


>> and the timing n_BS (time between first frame
>> reception and flow control emission)?
>
> N_Bs = N_Br + N_Ar
>
> N_Ar is defined by the frame transmission time (on the real CAN bus)
> N_Br has no setting but only a performance requirement:
>
> N_Br + N_Ar < 0.9 * N_Bs timeout
>
> N_Bs timeout = 1000ms => N_Br + N_Ar < 900ms
>
> So AFAICS there's no way to specify N_Br. It can be as small as possible.
> Therefore N_Bs is at least N_Ar + some various time for the protocol machine.

Hum, this can be a blocking fact for some ECU diagnostic.
I had this implementation (sending flow control as quick as possible),
and some ECUs (seen on PSA car) did not answer to the request, because
i had not 25ms before flow control sending.
>
>> In the same way, is it possible to
>> specify according timeout (n_BR for flow control timeout reception, and n_CR
>> for consecutive frame timeout reception)?
>
> Due to the spec these timeouts are defined to be 1000ms.
> Or did I miss something here?
>
Coming from diagnostic, i prefer to be able to configure all protocol
timing (in order to deal with the maximum ECU number (even very old
ecu, which may be very slow). Constructor gives us the timing we must
respect, sometimes different from the normalization....
but 1000ms is enough i think for most of the case.
> Regards,
> Oliver
>
regards
Laurent
