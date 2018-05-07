From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 01/18] docs: can.rst: fix a footnote reference
Date: Mon, 7 May 2018 20:41:43 +0200
Message-ID: <8e12e344-0b16-fd92-8a5d-d40aca501c7b@hartkopp.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
 <2a04ab24f302a0802572c4c80c4d416b953f213d.1525684985.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <2a04ab24f302a0802572c4c80c4d416b953f213d.1525684985.git.mchehab+samsung@kernel.org>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org

+ Robert Schwebel (who thankfully did the txt -> rst conversion for can.txt)

On 05/07/2018 11:35 AM, Mauro Carvalho Chehab wrote:
> As stated at:
> 	http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#footnotes
> 
> A footnote should contain either a number, a reference or
> an auto number, e. g.:
> 	[1], [#f1] or [#].
> 
> While using [*] accidentaly works for html, it fails for other
> document outputs. In particular, it causes an error with LaTeX
> output, causing all books after networking to not be built.
> 
> So, replace it by a valid syntax.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Mauro!

Best regards,
Oliver

> ---
>  Documentation/networking/can.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index d23c51abf8c6..2fd0b51a8c52 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -164,7 +164,7 @@ The Linux network devices (by default) just can handle the
>  transmission and reception of media dependent frames. Due to the
>  arbitration on the CAN bus the transmission of a low prio CAN-ID
>  may be delayed by the reception of a high prio CAN frame. To
> -reflect the correct [*]_ traffic on the node the loopback of the sent
> +reflect the correct [#f1]_ traffic on the node the loopback of the sent
>  data has to be performed right after a successful transmission. If
>  the CAN network interface is not capable of performing the loopback for
>  some reason the SocketCAN core can do this task as a fallback solution.
> @@ -175,7 +175,7 @@ networking behaviour for CAN applications. Due to some requests from
>  the RT-SocketCAN group the loopback optionally may be disabled for each
>  separate socket. See sockopts from the CAN RAW sockets in :ref:`socketcan-raw-sockets`.
>  
> -.. [*] you really like to have this when you're running analyser
> +.. [#f1] you really like to have this when you're running analyser
>         tools like 'candump' or 'cansniffer' on the (same) node.
>  
>  
> 
