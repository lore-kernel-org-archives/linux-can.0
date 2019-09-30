From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs: use flexible array members, not zero-length
Date: Mon, 30 Sep 2019 11:00:57 -0600
Message-ID: <20190930110057.1b11d798@lwn.net>
References: <20190927142927.27968-1-steve@sk2.org>
        <20190928011639.7c983e77@lwn.net>
        <20190928105557.221fb119@heffalump.sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190928105557.221fb119@heffalump.sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>
Cc: linux-doc@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-can@vger.kernel.org, linux-afs@lists.infradead.org, kvm@vger.kernel.org, "Gustavo A . R . Silva" <gustavo@embeddedor.com>
List-Id: linux-can.vger.kernel.org

On Sat, 28 Sep 2019 10:55:57 +0200
Stephen Kitt <steve@sk2.org> wrote:

> Wouldn’t it be better to update the docs simultaneously in each patch which
> fixes a structure? Or is that unworkable with current development practices?

Definitely update the two together.  The doc fix should just go through
the appropriate maintainer with the code change.

Thanks,

jon
