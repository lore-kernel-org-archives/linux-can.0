From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [can:master 110/171]
 drivers/net/ethernet/intel/igb/igb.h:347:25: error: field 'hwtstamp_config'
 has incomplete type
Date: Tue, 25 Sep 2012 20:22:18 +0800
Message-ID: <20120925122218.GB4545@localhost>
References: <20120921121642.GA17278@localhost>
 <06DFBC1E25D8024DB214DC7F41A3CD34488EFFFC@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41722 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab2IYMW0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 25 Sep 2012 08:22:26 -0400
Content-Disposition: inline
In-Reply-To: <06DFBC1E25D8024DB214DC7F41A3CD34488EFFFC@ORSMSX101.amr.corp.intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Vick, Matthew" <matthew.vick@intel.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Sat, Sep 22, 2012 at 07:38:12AM +0800, Vick, Matthew wrote:
> > -----Original Message-----
> > From: Wu, Fengguang
> > Sent: Friday, September 21, 2012 5:17 AM
> > To: Vick, Matthew
> > Cc: kernel-janitors@vger.kernel.org; Kirsher, Jeffrey T; linux-
> > can@vger.kernel.org
> > Subject: [can:master 110/171]
> > drivers/net/ethernet/intel/igb/igb.h:347:25: error: field
> > 'hwtstamp_config' has incomplete type
> >=20
> > Hi Matthew,
> >=20
> > FYI, kernel build failed on
> >=20
> > tree:   git://gitorious.org/linux-can/linux-can-next master
> > head:   a1161bc7bdf4eedccb1b91e7479f303cf95af533
> > commit: 3c89f6d0d4aa92ff252c17f8f6b5c8983ae2b77e [110/171] igb: Tid=
y up
> > wrapping for CONFIG_IGB_PTP.
> > config: x86_64-allyesdebian (attached as .config)
> >=20
> > All related error/warning messages:
> >=20
> > In file included from
> > drivers/net/ethernet/intel/igb/igb_ethtool.c:41:0:
> > drivers/net/ethernet/intel/igb/igb.h:347:25: error: field
> > 'hwtstamp_config' has incomplete type
> > --
> > In file included from drivers/net/ethernet/intel/igb/e1000_mac.c:36=
:0:
> > drivers/net/ethernet/intel/igb/igb.h:347:25: error: field
> > 'hwtstamp_config' has incomplete type
> >=20
> > vim +347 drivers/net/ethernet/intel/igb/igb.h
> >    341		u8  tx_timeout_factor;
> >    342		struct timer_list blink_timer;
> >    343		unsigned long led_status;
> >    344
> >    345		/* OS defined structs */
> >    346		struct pci_dev *pdev;
> >  > 347		struct hwtstamp_config hwtstamp_config;
> >    348
> >    349		spinlock_t stats64_lock;
> >    350		struct rtnl_link_stats64 stats64;
> >=20
> > ---
> > 0-DAY kernel build testing backend         Open Source Technology
> > Centre
> > Fengguang Wu, Yuanhan Liu                              Intel
> > Corporation
>=20
> Fengguang,
>=20
> I'm not certain I understand how this issue came back to me. The
> patch in question doesn't touch that code, nor should it be changing
> anything that would cause a build error here. The offending line is
> also removed in the next patch
> (a79f4f88261d7fd492121daf85beafff663f1f01). I'm also unable to
> reproduce the error.

Hi Matthew, this is interesting, but I do reproduced the issue by
building 3c89f6d0d4aa92ff252c17f8f6b5c8983ae2b77e from scratch with
the originally attached config file:

  CC      drivers/net/ethernet/qlogic/qla3xxx.o
  CC      drivers/net/ethernet/intel/ixgbevf/mbx.o
  CC      drivers/net/ethernet/intel/ixgbe/ixgbe_main.o
  CC      drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.o
  CC      drivers/net/ethernet/intel/ixgbevf/ethtool.o
  CC      drivers/net/ethernet/intel/igb/e1000_i210.o
  CC      drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.o
  CC      drivers/net/ethernet/intel/ixgbe/ixgbe_common.o
  CC      drivers/net/ethernet/realtek/r8169.o
  CC      drivers/net/ethernet/qlogic/netxen/netxen_nic_main.o
In file included from /c/wfg/linux/drivers/net/ethernet/intel/igb/igb_e=
thtool.c:41:0:
/c/wfg/linux/drivers/net/ethernet/intel/igb/igb.h:347:25: error: field =
=E2=80=98hwtstamp_config=E2=80=99 has incomplete type
  CC      drivers/net/ethernet/qlogic/netxen/netxen_nic_init.o
In file included from /c/wfg/linux/drivers/net/ethernet/intel/igb/e1000=
_mac.c:36:0:
/c/wfg/linux/drivers/net/ethernet/intel/igb/igb.h:347:25: error: field =
=E2=80=98hwtstamp_config=E2=80=99 has incomplete type
make[6]: *** [drivers/net/ethernet/intel/igb/e1000_mac.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      drivers/net/ethernet/qlogic/netxen/netxen_nic_ethtool.o
make[6]: *** [drivers/net/ethernet/intel/igb/igb_ethtool.o] Error 1

Thanks,
=46engguang
