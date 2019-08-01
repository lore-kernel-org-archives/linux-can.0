From: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Subject: Re: [PATCH] can: flexcan: free error skb if enqueueing failed
Date: Thu, 1 Aug 2019 09:59:32 +0200
Message-ID: <d5f8811e-4b85-776a-668f-33f64ec6ef16@geanix.com>
References: <20190715185308.104333-1-martin@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190715185308.104333-1-martin@geanix.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
List-Id: linux-can.vger.kernel.org

On 15/07/2019 20.53, Martin Hundebøll wrote:
> If the call to can_rx_offload_queue_sorted() fails, the passed skb isn't
> consumed, so the caller must do so.
> 
> Fixes: 30164759db1b ("can: flexcan: make use of rx-offload's irq_offload_fifo")
> Signed-off-by: Martin Hundebøll <martin@geanix.com>

Ping.
