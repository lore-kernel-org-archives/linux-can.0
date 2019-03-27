From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC] net: sch_generic: fq_codel vs pfifo_fast
Date: Wed, 27 Mar 2019 11:30:59 -0700
Message-ID: <20190327113059.6b1224ab@shemminger-XPS-13-9360>
References: <20190327165632.10711-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190327165632.10711-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
List-Id: linux-can.vger.kernel.org

On Wed, 27 Mar 2019 17:56:30 +0100
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Hello,
> 
> on CAN networking hardware we (the CAN community) experience a lot silent,
> unwanted frame drops inside the kernel. (See first patch for details.) So
> here's a patch series to keep pfifo_fast as default scheduler for CAN hardware
> by default.
> 
> Consider this as an RFC. Regards,
> Marc
> 
> 

Why do you set fq_codel as default qdisc if you know it doesn't work right for your
environment. Is this a distro's want one value problem?
