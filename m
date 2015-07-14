From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Fighting out-of-order reception with RPS?
Date: Tue, 14 Jul 2015 21:05:17 +0200
Message-ID: <55A55D6D.7090805@hartkopp.net>
References: <1436763470.24939.66.camel@edumazet-glaptop2.roam.corp.google.com>	<55A5424B.2000803@hartkopp.net>	<CALx6S37TMbi0s4LK_j=VyZB0-vEHBWF4nFJsNSfQOz5D-Q0ksw@mail.gmail.com> <20150714.120315.218180667705835403.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20150714.120315.218180667705835403.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, tom@herbertland.com
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, linux-can@vger.kernel.org, sunil.kovvuri@gmail.com, jonathon.reinhart@gmail.com
List-Id: linux-can.vger.kernel.org



On 14.07.2015 21:03, David Miller wrote:
> From: Tom Herbert <tom@herbertland.com>
> Date: Tue, 14 Jul 2015 11:02:16 -0700
>
>> then implement NAPI for CAN drivers as has been suggested now by
>> three very experienced developers. This solves the your OOO problem
>> and moves drivers to NAPI which is the greatly preferred interface.
>
> +1
>
> +1
>
> +1

ok got it :-)
