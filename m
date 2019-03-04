From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v6 2/4] can: m_can: Rename m_can_priv to m_can_classdev
Date: Mon, 4 Mar 2019 18:31:51 +0100
Message-ID: <093eb838-ab28-0bc0-8855-a8b22f3392b4@grandegger.com>
References: <20190301185043.9037-1-dmurphy@ti.com>
 <20190301185043.9037-2-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301185043.9037-2-dmurphy@ti.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de, davem@davemloft.net
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello,

there are still "LTL" after renaming m_can_priv to m_can_classdev.

Am 01.03.19 um 19:50 schrieb Dan Murphy:
> Rename the common m_can_priv class structure to
> m_can_classdev as this is more descriptive.

If you change the struct name, I think you should also change the
variable name to something more meaning full e.g.:

  struct m_can_classdev *cdev

instead of

  struct m_can_classdev *priv


... snip ...

Wolfgang.
