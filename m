From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 1/2] net: sch_generic: add flag IFF_FIFO_QUEUE to use
 pfifo_fast as default scheduler
Date: Wed, 27 Mar 2019 13:53:40 -0700
Message-ID: <CAM_iQpVVJVXGLmEWfNj-MG6j4pyYp3TOV7gcnBZ0-9OrMWEa=A@mail.gmail.com>
References: <20190327165632.10711-1-mkl@pengutronix.de> <20190327165632.10711-2-mkl@pengutronix.de>
 <CAM_iQpWVOeJ7JNnFyrnvVVimfO=nn4z2FsCGHcDxgeDYQKoYgQ@mail.gmail.com> <7a25d800-aed1-bec6-0ff8-38c06c3b8fb5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <7a25d800-aed1-bec6-0ff8-38c06c3b8fb5@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jiri Pirko <jiri@resnulli.us>, Linux Kernel Network Developers <netdev@vger.kernel.org>, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, kernel@pengutronix.de, linux-can@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: linux-can.vger.kernel.org

On Wed, Mar 27, 2019 at 1:11 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Doubts aside, how should an arbitrary default qdisc per netdevice look
> like? Add a string "default_qdisc" to the netdev? Lookup qdisc by string
> during DOWN->UP transition? What do if that qdisc is not compiled into
> the kernel? Or rather use an array of qdiscs with one of sch_generic
> defaults?

I think you can just save a Qdisc_ops pointer in netdevice,
like how we install the default qdisc:

  38 const struct Qdisc_ops *default_qdisc_ops = &pfifo_fast_ops;
  39 EXPORT_SYMBOL(default_qdisc_ops);

And hard-code whatever default into your netdevice init code.

At least for pfifo_fast, you don't need to worry about module
loading. If you really do, you can call qdisc_lookup_default()
and request_module() like what qdisc_set_default() does.
Of course, you can refactor qdisc_set_default() and call it too.

Thanks.
