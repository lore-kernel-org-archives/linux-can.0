From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v3 0/4] Consolidate and unify state change handling
Date: Sun, 23 Nov 2014 20:35:50 +0100
Message-ID: <54723716.5000509@grandegger.com>
References: <212bdd30-5398-4189-b928-5b9e674ebaa8@GRBSR0089.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:34295 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbaKWTf5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 23 Nov 2014 14:35:57 -0500
In-Reply-To: <212bdd30-5398-4189-b928-5b9e674ebaa8@GRBSR0089.marel.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andri Yngvason <andri.yngvason@marel.com>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de

On 11/22/2014 06:41 PM, Andri Yngvason wrote:
> Tested on sja1000 using:
>  cangen -g 100 can0
> and
>  candump -ta -e can0,0:0,#FFFFFFFF
> 
> Disconnected bus:
>  (1416682965.087306)  can0  2DF   [3]  2F 15 26
>  (1416682965.187328)  can0  674   [2]  21 A1
>  (1416682965.287815)  can0  33D   [8]  CF 0C 45 21 FC 04 2E 09
>  (1416682965.393608)  can0  20000004   [8]  00 08 00 00 00 00 60 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
> 	error-counter-tx-rx{{96}{0}}
>  (1416682965.395955)  can0  20000004   [8]  00 20 00 00 00 00 80 00   ERRORFRAME
> 	controller-problem{tx-error-passive}
> 	error-counter-tx-rx{{128}{0}}
>  (1416682976.869871)  can0  2DC   [2]  79 2E
>  (1416682976.870595)  can0  560   [4]  C3 7C 00 01
>  (1416682976.871569)  can0  2DB   [8]  25 81 69 50 BD 59 8F 57
> ...
>  (1416682976.876007)  can0  05B   [8]  A6 4D C6 30 37 C3 F7 69
>  (1416682976.876993)  can0  22A   [8]  A7 AF 8E 03 8A FF 4A 6B
>  (1416682976.877002)  can0  20000004   [8]  00 08 00 00 00 00 7F 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
> 	error-counter-tx-rx{{127}{0}}
>  (1416682976.877956)  can0  233   [8]  34 3F 95 0C 0E 8D 0E 46
>  (1416682976.878905)  can0  2B8   [8]  CB E6 9D 1D B8 C6 F2 17
>  (1416682976.879856)  can0  2FB   [8]  0B F6 B7 6F 58 45 57 31
> ...
>  (1416682976.902282)  can0  4FC   [0] 
>  (1416682976.903230)  can0  053   [8]  E1 11 39 26 F1 8B 9F 19
>  (1416682976.903799)  can0  5B4   [2]  39 96
>  (1416682976.903808)  can0  20000004   [8]  00 40 00 00 00 00 5F 00   ERRORFRAME
> 	controller-problem{back-to-error-active}
> 	error-counter-tx-rx{{95}{0}}
>  (1416682976.904363)  can0  196   [2]  B6 C7
>  (1416682976.905340)  can0  61F   [8]  B3 F6 C2 0A 39 F1 26 70
>  (1416682976.905970)  can0  55D   [3]  90 E5 5F
> 
> Shorted bus:
>  (1416683058.868100)  can0  525   [2]  7D 3F
>  (1416683058.968532)  can0  6FC   [7]  F3 92 FE 39 37 6E 89
>  (1416683059.068595)  can0  284   [7]  AC 5F 79 4D 66 EF 3C
>  (1416683059.167980)  can0  20000004   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
> 	controller-problem{tx-error-passive}
> 	error-counter-tx-rx{{136}{0}}
>  (1416683059.171146)  can0  20000040   [8]  00 00 00 00 00 00 7F 00   ERRORFRAME
> 	bus-off
> 	error-counter-tx-rx{{127}{0}}
>  (1416683059.220803)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	restarted-after-bus-off
>  (1416683059.268077)  can0  20000004   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
> 	controller-problem{tx-error-passive}
> 	error-counter-tx-rx{{136}{0}}
>  (1416683059.271238)  can0  20000040   [8]  00 00 00 00 00 00 7F 00   ERRORFRAME
> 	bus-off
> 	error-counter-tx-rx{{127}{0}}
>  (1416683059.320803)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	restarted-after-bus-off
> ...
>  (1416683061.470255)  can0  20000004   [8]  00 20 00 00 00 00 88 00   ERRORFRAME
> 	controller-problem{tx-error-passive}
> 	error-counter-tx-rx{{136}{0}}
>  (1416683061.473420)  can0  20000040   [8]  00 00 00 00 00 00 7F 00   ERRORFRAME
> 	bus-off
> 	error-counter-tx-rx{{127}{0}}
>  (1416683061.522799)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	restarted-after-bus-off
>  (1416683061.571115)  can0  643   [8]  D9 BB 20 19 28 A0 56 77
>  (1416683061.671163)  can0  736   [7]  62 00 39 0E 13 F4 7E
>  (1416683061.770988)  can0  2E4   [3]  D2 3F C0

This looks now good for the SJA1000 ...

> Tested on mscan using:
>  cangen -g 100 can0
> and
>  candump -ta -e can0,0:0,#FFFFFFFF
> 
> Disconnected bus:
>  (0000088443.957752)  can0  34C   [0] 
>  (0000088444.058159)  can0  2F4   [4]  10 0F 6F C6
>  (0000088444.158494)  can0  7A9   [8]  4D 81 52 6B 19 D6 66 C8
>  (0000088444.269206)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
>  (0000088444.273055)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-passive}
>  (0000088448.329598)  can0  767   [8]  5F 93 2B 62 6A B3 60 48
>  (0000088448.330052)  can0  5F6   [0] 
>  (0000088448.330651)  can0  782   [2]  7F F8
> ...
>  (0000088448.340011)  can0  2BE   [6]  7B 4E E8 41 1F 1F
>  (0000088448.340833)  can0  4E7   [6]  3D 09 BA 75 4D C2
>  (0000088448.341817)  can0  42C   [8]  76 7E A2 B6 3E 88 19 53
>  (0000088448.341923)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
>  (0000088448.342207)  can0  611   [0] 
>  (0000088448.342735)  can0  7B9   [2]  79 FE
>  (0000088448.343375)  can0  147   [4]  23 DD F6 38
> ...
>  (0000088448.864031)  can0  017   [6]  56 15 6B E3 4D 13
>  (0000088448.964286)  can0  347   [8]  2D 12 D3 CD 5E 37 AC 7C
>  (0000088449.064405)  can0  146   [8]  5A FD 12 87 17 62 86 4F
>  (0000088449.064492)  can0  20000004   [8]  00 40 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{back-to-error-active}
>  (0000088449.164524)  can0  593   [8]  5B 83 65 74 70 8B 57 7F
>  (0000088449.264516)  can0  6FB   [6]  31 0D D3 96 6C 8E
>  (0000088449.364658)  can0  32D   [6]  18 88 2A A0 30 13
> 
> Shorted bus:
>  (0000088453.570871)  can0  345   [8]  6C 0E BA 6E 4D 93 F7 0B
>  (0000088453.670542)  can0  0CE   [1]  11
>  (0000088453.770909)  can0  5D9   [4]  4F BB E3 CE
>  (0000088453.870536)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
>  (0000088453.873732)  can0  20000040   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	bus-off
>  (0000088453.923596)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	restarted-after-bus-off
>  (0000088453.923883)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
>  (0000088453.927086)  can0  20000040   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	bus-off
>  (0000088453.976592)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	restarted-after-bus-off
>  (0000088454.071587)  can0  07F   [7]  4A 5B 1E B3 5F 63 1E
>  (0000088454.171299)  can0  092   [1]  5A
>  (0000088454.271898)  can0  492   [8]  41 1C 23 91 77 76 27 D7

and MSCAN.

> Tested on flexcan using:
>  cangen -g 1000 can0
>  cangen -g 1000 can1
> and
>  candump -ta -e can0,0:0,#FFFFFFFF
> and
>  berr-reporting on

I think you need this because your Flexcan platform data are wrong as
mentioned earlier.

> Disconnected bus:
>  (000.190615)  can0  2AA   [3]  2F 73 B5
>  (000.809397)  can0  3B5   [7]  1F C1 79 77 5D 56 3E
>  (000.190926)  can0  4AA   [6]  8A 01 7F 1B 43 CA
>  (001.007441)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
> 	protocol-violation{{}{acknowledge-slot}}
> 	no-acknowledgement-on-tx
> 	bus-error
>  (000.007059)  can0  20000004   [8]  00 20 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-passive}
>  (000.005085)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
> 	protocol-violation{{}{acknowledge-slot}}
> 	no-acknowledgement-on-tx
> 	bus-error
> ...
>  (000.010527)  can0  200000A8   [8]  00 00 00 19 00 00 00 00   ERRORFRAME
> 	protocol-violation{{}{acknowledge-slot}}
> 	no-acknowledgement-on-tx
> 	bus-error
>  (000.005166)  can0  5C8   [3]  95 69 4D
>  (000.015339)  can0  200000A8   [8]  00 00 14 19 00 00 00 00   ERRORFRAME
> 	protocol-violation{{bit-stuffing-error,tx-recessive-bit-error}{acknowledge-slot}}
> 	no-acknowledgement-on-tx
> 	bus-error
>  (000.000000)  can0  04A   [2]  39 32
>  (000.005245)  can0  495   [0] 
>  (000.010367)  can0  532   [8]  D4 A9 BB 63 DD 17 F1 5D
>  ...
>  (000.809164)  can0  0A7   [8]  75 E0 DC 41 D9 9D 3F 62
>  (000.190956)  can0  48C   [8]  C7 0D 5D 4D 21 09 DA 2A
>  (000.809165)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
>  (000.000015)  can0  04B   [8]  B6 B5 30 40 3D 1D 58 7C
>  (000.190931)  can0  44B   [8]  F9 AC C8 10 CF 16 F4 58
>  (000.809164)  can0  2CB   [8]  13 A2 E5 06 C4 94 14 4B
> ...
>  (000.190798)  can0  118   [8]  B4 6C 6F 55 8B E3 82 04
>  (000.808995)  can0  47C   [3]  CE EE 41
>  (000.191086)  can0  2EB   [8]  B6 3C D6 38 C5 86 0A 1A
>  (000.809276)  can0  20000004   [8]  00 40 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{back-to-error-active}
>  (000.000017)  can0  4F3   [7]  B6 87 9D 12 C5 0B FC
>  (000.190819)  can0  0D3   [8]  5B 85 38 28 7D F9 D4 32
>  (000.809272)  can0  5A7   [7]  B7 74 DC 5E 41 0E D9
> 
> Shorted bus:
>  (000.809289)  can0  72F   [6]  69 DD 64 0A B1 07
>  (000.190744)  can0  26E   [7]  1E CE 76 36 07 44 58
>  (000.999302)  can0  20000004   [8]  00 08 00 00 00 00 00 00   ERRORFRAME
> 	controller-problem{tx-error-warning}
>  (000.005177)  can0  20000088   [8]  00 00 08 00 00 00 00 00   ERRORFRAME
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	bus-error
>  (000.008899)  can0  20000040   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	bus-off
>  (000.005158)  can0  20000088   [8]  00 00 08 00 00 00 00 00   ERRORFRAME
> 	protocol-violation{{tx-dominant-bit-error}{}}
> 	bus-error
>  (000.040123)  can0  20000100   [8]  00 00 00 00 00 00 00 00   ERRORFRAME
> 	restarted-after-bus-off
>  (000.750963)  can0  6BF   [8]  5A 26 E0 13 B3 FA DE 0E
>  (000.190390)  can0  6CD   [4]  09 97 46 75
>  (000.809340)  can0  5EC   [2]  9A 2B

Looks good as well. Would be nice if you use cangen with a message count
in the data.

> Note: I made the following changes to can-utils:
> diff --git a/lib.c b/lib.c
> index 2c8df32..973be52 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -446,6 +446,7 @@ static const char *controller_problems[] = {
>  	"tx-error-warning",
>  	"rx-error-passive",
>  	"tx-error-passive",
> +	"back-to-error-active",
>  };
>  
>  static const char *protocol_violation_types[] = {
> @@ -455,7 +456,7 @@ static const char *protocol_violation_types[] = {
>  	"tx-dominant-bit-error",
>  	"tx-recessive-bit-error",
>  	"bus-overload",
> -	"back-to-error-active",
> +	"active-error",
>  	"error-on-tx",
>  };
> 
> Andri Yngvason (4):
>   can: dev: Consolidate and unify state change handling.
>   can: sja1000: Consolidate and unify state change handling.
>   can: mscan: Consolidate and unify state change handling.
>   can: flexcan: Consolidate and unify state change handling.
> 
>  drivers/net/can/dev.c             |  94 +++++++++++++++++++++++++++++++++++
>  drivers/net/can/flexcan.c         | 101 +++++++-------------------------------
>  drivers/net/can/mscan/mscan.c     |  48 ++++++------------
>  drivers/net/can/sja1000/sja1000.c |  49 +++++++++---------
>  include/linux/can/dev.h           |   4 ++
>  include/uapi/linux/can/error.h    |   1 +
>  6 files changed, 153 insertions(+), 144 deletions(-)

I will have a closer look to the patches tomorrow.

Thanks,

Wolfgang.


