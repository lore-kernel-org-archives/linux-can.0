From: Deniz Eren <deniz.eren@icloud.com>
Subject: Re: [PATCH] CAN bus MIOe-3680 PCI (dual SJA1000
 channel) emulation added.
Date: Sun, 18 Sep 2016 14:33:46 +1000
Message-ID: <7E84D469-0C5E-46FA-9218-2AB54A67C6B0@icloud.com>
References: <1473145132-20895-1-git-send-email-deniz.eren@icloud.com>
	<201609081910.28236.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-reply-to: <201609081910.28236.pisa@cmp.felk.cvut.cz>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: "Qemu-devel" <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: pbonzini@redhat.com, jasowang@redhat.com, rizzo@iet.unipi.it, qemu-devel@nongnu.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hi Pavel,

Thank you for the merge - CAN-bus support for QEMU is very important in my o=
pinion. Most embedded applications utilise CAN and virtualising this interfa=
ce gives an amazing integration test harness.



Best regards,
Deniz

Sent from my iPhone

Deniz Eren
+61 400 307 762

> On 9 Sep. 2016, at 3:10 am, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
>=20
> Hello Deniz,
>=20
> thanks much for contribution and testing.
>=20
> I have applied your patches to our QEMU
> repo
>=20
>  https://github.com/CTU-IIG/qemu
>=20
> You find QEMU-2.6.1 based version of our merged
> patches on "merged-2.6" branch.
>=20
> I have updated and shortly tested all our topic branches
> with actual QEMU-2.7.0 release. Simple test with
> Linux within Linux and SocketCAN on both sides
> works for PCI CAN-S (single SJA1000 channel) card
> well with QEMU-2.7.0.
>=20
> So I have undated all topics branches "can-pci",
> "mf624" and "apohw" to this version then and created
> "merged-2.7" branch. "merged" branch is now moved
> to "merged-2.7" as well.
>=20
> Your offer to help with mainlining is great as well.
> Some discussion with somebody from core QEMU team
> member is required.
>=20
> I hope that actual CAN chip driver and PCI cards
> follow QOM model right way. Problem is the simple
> bus used for mesages delivery between CAN controllers.
> These buses should be converted somehow to QOM acceptable
> model. But for embedded development when you do not
> freeze emulated system state is actual solution quite
> usable as well.
>=20
> It would be great to implement CAN FD (Flexible Datarate)
> controller emulation support as well.
>=20
> I am trying to find some diploma student for that for
> two years already because he/she can have continuous
> time for such work and testing which I cannot find.
> Help from other instreested or project users would
> be great as well.
>=20
> Best wishes,
>=20
>              Pavel
>=20
>=20
>=20
>=20
