From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Linux
Date: Thu, 14 Apr 2016 12:03:14 +0200
Message-ID: <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
References: <20160408090444.GA5485@airbook.vandijck-laurijssen.be>
 <570793F6.7080808@eurek.it>
 <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
 <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709986A@POCITMSEXMB05.LntUniverse.com>
 <20160412082020.GA19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709A50F@POCITMSEXMB05.LntUniverse.com>
 <20160412181540.GE19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:51023 "EHLO
	relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbcDNKGO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 06:06:14 -0400
Content-Disposition: inline
In-Reply-To: <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
Cc: gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I pushed j1939d-v3.19.

I created the branch by merging & cherry-pick, as suggested earlier.
I didn't have compile problems.

I have not tested it, yet I foresee no problems, or at least no
differences compared to my other j1939d-vx.xx branches.

Kind regards,
Kurt

--- Original message ---
> Date: Wed, 13 Apr 2016 16:08:33 +0000
> From: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> CC: gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org"
>  <linux-can@vger.kernel.org>
> Subject: RE: J1939 Linux
>=20
> Kurt,
> Do you have v3.19 for me to build and test?
>=20
>=20
> Regards
> Dinesh Velayudham
> L&T Technology Services
> dinesh.velayutham@lnttechservices.com
> +1-309-740-7691
>=20
> -----Original Message-----
> From: Dinesh Velayudham
> Sent: Tuesday, April 12, 2016 1:28 PM
> To: 'Kurt Van Dijck'
> Cc: gianluca; linux-can@vger.kernel.org
> Subject: RE: J1939 Linux
>=20
> I don=E2=80=99t think this will work as the cherry-pick only changes =
the socket.c file. The " memcpy_toiovec" has been used in few more plac=
es e.g /include/linux/skbuff.h,
>=20
>=20
> Regards
> Dinesh Velayudham
> L&T Technology Services
> dinesh.velayutham@lnttechservices.com
> +1-309-740-7691
>=20
> -----Original Message-----
> From: Kurt Van Dijck [mailto:dev.kurt@vandijck-laurijssen.be]
> Sent: Tuesday, April 12, 2016 1:16 PM
> To: Dinesh Velayudham
> Cc: gianluca; linux-can@vger.kernel.org
> Subject: Re: J1939 Linux
>=20
> I apologise, I have given you the wrong commit to cherry-pick.
> I gave the API change commit, and you need the one that adapts it for=
 can-j1939.
> So forget the previous email (reset the git HEAD) and do
>=20
>         git cherry-pick 34bb840
>=20
> Kind regards,
> Kurt
>=20
> --- Original message ---
> > Date: Tue, 12 Apr 2016 17:57:02 +0000
> > From: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
> > To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > CC: gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org"
> >  <linux-can@vger.kernel.org>
> > Subject: RE: J1939 Linux
> >
> > Kurt,
> > I am still facing build error
> > 1. cherry pick the code
> > 2. make clean
> > 3. make deb-pkg
> >
> > $ git cherry-pick 7eab8d9e
> > [master bf6fe85] new helper: memcpy_to_msg()
> >  Author: Al Viro <viro@zeniv.linux.org.uk>
> >  1 file changed, 5 insertions(+)
> >
> > $ make clean
> >   CLEAN   .
> >   CLEAN   arch/x86/kernel/cpu
> >   CLEAN   arch/x86/kernel
> >   CLEAN   arch/x86/purgatory
> >   CLEAN   arch/x86/realmode/rm
> >   CLEAN   arch/x86/vdso
> >   CLEAN   arch/x86/lib
> >   CLEAN   crypto/asymmetric_keys
> >   CLEAN   drivers/gpu/drm/radeon
> >   CLEAN   drivers/net/wan
> >   CLEAN   drivers/scsi/aic7xxx
> >   CLEAN   drivers/tty/vt
> >   CLEAN   firmware
> >   CLEAN   kernel/debug/kdb
> >   CLEAN   kernel/time
> >   CLEAN   kernel
> >   CLEAN   lib/raid6
> >   CLEAN   lib
> >   CLEAN   security/apparmor
> >   CLEAN   security/selinux
> >   CLEAN   usr
> >   CLEAN   arch/x86/boot/compressed
> >   CLEAN   arch/x86/boot
> >   CLEAN   arch/x86/tools
> >   CLEAN   .tmp_versions
> >
> > $ make -j 4 V=3D2 deb-pkg LOCALVERSION=3D-custom 2>&1 | tee buildlo=
g.txt
> > In file included from include/crypto/algapi.h:18:0,
> >                  from include/crypto/internal/hash.h:16,
> >                  from arch/x86/crypto/crc32c-intel_glue.c:31:
> > include/linux/skbuff.h:2710:19: error: redefinition of =E2=80=98mem=
cpy_to_msg=E2=80=99
> >  static inline int memcpy_to_msg(struct msghdr *msg, void *data, in=
t len)
> >                    ^
> > include/linux/skbuff.h:2705:19: note: previous definition of
> > =E2=80=98memcpy_to_msg=E2=80=99 was here  static inline int memcpy_=
to_msg(struct msghdr *msg, void *data, int len)
> >                    ^
> > include/linux/skbuff.h: In function =E2=80=98memcpy_to_msg=E2=80=99=
:
> > include/linux/skbuff.h:2712:2: error: implicit declaration of funct=
ion =E2=80=98memcpy_toiovec=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >   ^
> > include/linux/skbuff.h:2712:27: error: =E2=80=98struct msghdr=E2=80=
=99 has no member named =E2=80=98msg_iov=E2=80=99
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >                            ^
> > cc1: some warnings being treated as errors
> > make[4]: *** [arch/x86/crypto/crc32c-intel_glue.o] Error 1
> > make[3]: *** [arch/x86/crypto] Error 2
> > make[3]: *** Waiting for unfinished jobs....
> >   CC      kernel/exec_domain.o - due to target missing
> >   CC      arch/x86/ia32/ia32_signal.o - due to target missing
> >   CC      init/do_mounts.o - due to target missing
> > In file included from include/linux/netfilter.h:5:0,
> >                  from include/net/netns/netfilter.h:5,
> >                  from include/net/net_namespace.h:22,
> >                  from include/linux/init_task.h:15,
> >                  from kernel/fork.c:534:
> > include/linux/skbuff.h:2710:19: error: redefinition of =E2=80=98mem=
cpy_to_msg=E2=80=99
> >  static inline int memcpy_to_msg(struct msghdr *msg, void *data, in=
t len)
> >                    ^
> > include/linux/skbuff.h:2705:19: note: previous definition of
> > =E2=80=98memcpy_to_msg=E2=80=99 was here  static inline int memcpy_=
to_msg(struct msghdr *msg, void *data, int len)
> >                    ^
> > include/linux/skbuff.h: In function =E2=80=98memcpy_to_msg=E2=80=99=
:
> > include/linux/skbuff.h:2712:2: error: implicit declaration of funct=
ion =E2=80=98memcpy_toiovec=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >   ^
> > include/linux/skbuff.h:2712:27: error: =E2=80=98struct msghdr=E2=80=
=99 has no member named =E2=80=98msg_iov=E2=80=99
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >                            ^
> > cc1: some warnings being treated as errors
> > make[3]: *** [kernel/fork.o] Error 1
> > make[2]: *** [kernel] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   CC      init/do_mounts_rd.o - due to target missing
> >   CC      arch/x86/ia32/nosyscall.o - due to target missing
> >   CC      arch/x86/ia32/syscall_ia32.o - due to target missing
> >   CC      init/do_mounts_initrd.o - due to target missing
> >   CC      arch/x86/ia32/audit.o - due to target missing
> >   LD      arch/x86/ia32/built-in.o - due to target missing
> > make[2]: *** [arch/x86] Error 2
> >   CC      init/do_mounts_md.o - due to target missing
> > In file included from include/linux/icmpv6.h:4:0,
> >                  from include/linux/ipv6.h:63,
> >                  from include/net/ipv6.h:16,
> >                  from include/linux/sunrpc/clnt.h:27,
> >                  from include/linux/nfs_fs.h:30,
> >                  from init/do_mounts.c:32:
> > include/linux/skbuff.h:2710:19: error: redefinition of =E2=80=98mem=
cpy_to_msg=E2=80=99
> >  static inline int memcpy_to_msg(struct msghdr *msg, void *data, in=
t len)
> >                    ^
> > include/linux/skbuff.h:2705:19: note: previous definition of
> > =E2=80=98memcpy_to_msg=E2=80=99 was here  static inline int memcpy_=
to_msg(struct msghdr *msg, void *data, int len)
> >                    ^
> > include/linux/skbuff.h: In function =E2=80=98memcpy_to_msg=E2=80=99=
:
> > include/linux/skbuff.h:2712:2: error: implicit declaration of funct=
ion =E2=80=98memcpy_toiovec=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >   ^
> > include/linux/skbuff.h:2712:27: error: =E2=80=98struct msghdr=E2=80=
=99 has no member named =E2=80=98msg_iov=E2=80=99
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >                            ^
> >   CC      init/initramfs.o - due to target missing
> >   CC      init/calibrate.o - due to target missing
> >   CC      init/init_task.o - due to target missing
> >   CC      init/version.o - due to target missing
> > cc1: some warnings being treated as errors
> > make[3]: *** [init/do_mounts.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > In file included from include/linux/netfilter.h:5:0,
> >                  from include/net/netns/netfilter.h:5,
> >                  from include/net/net_namespace.h:22,
> >                  from include/linux/init_task.h:15,
> >                  from init/init_task.c:1:
> > include/linux/skbuff.h:2710:19: error: redefinition of =E2=80=98mem=
cpy_to_msg=E2=80=99
> >  static inline int memcpy_to_msg(struct msghdr *msg, void *data, in=
t len)
> >                    ^
> > include/linux/skbuff.h:2705:19: note: previous definition of
> > =E2=80=98memcpy_to_msg=E2=80=99 was here  static inline int memcpy_=
to_msg(struct msghdr *msg, void *data, int len)
> >                    ^
> > include/linux/skbuff.h: In function =E2=80=98memcpy_to_msg=E2=80=99=
:
> > include/linux/skbuff.h:2712:2: error: implicit declaration of funct=
ion =E2=80=98memcpy_toiovec=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >   ^
> > include/linux/skbuff.h:2712:27: error: =E2=80=98struct msghdr=E2=80=
=99 has no member named =E2=80=98msg_iov=E2=80=99
> >   return memcpy_toiovec(msg->msg_iov, data, len);
> >                            ^
> > cc1: some warnings being treated as errors
> > make[3]: *** [init/init_task.o] Error 1
> > make[2]: *** [init] Error 2
> > make[1]: *** [deb-pkg] Error 2
> > make: *** [deb-pkg] Error 2
> >
> >
> > Regards
> > Dinesh Velayudham
> > L&T Technology Services
> > dinesh.velayutham@lnttechservices.com
> > +1-309-740-7691
> >
> > -----Original Message-----
> > From: Kurt Van Dijck [mailto:dev.kurt@vandijck-laurijssen.be]
> > Sent: Tuesday, April 12, 2016 3:20 AM
> > To: Dinesh Velayudham
> > Cc: gianluca; linux-can@vger.kernel.org
> > Subject: Re: J1939 Linux
> >
> > Ok, I see.
> > It had nothing to do with "make deb-pkg", it is a problem that I
> > didn't see that commit 7eab8d9e is necessary as of v3.19, where I o=
nly
> > saw that v4.1 needed it.
> >
> > Please do:
> >
> >         $ git cherry-pick 7eab8d9e
> >
> > and the make should succeed.
> >
> > Sorry for not seeing this. I will try to prepare a j1939d-v3.19
> > branch, which will have that commit included.
> >
> > Kind regards,
> > Kurt
> >
> > --- Original message ---
> > > Date: Mon, 11 Apr 2016 22:11:11 +0000
> > > From: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
> > > To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > > CC: gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org=
"
> > >  <linux-can@vger.kernel.org>
> > > Subject: RE: J1939 Linux
> > >
> > > Kurt,
> > > I have attached text file that contains output of make command wi=
th
> > > V=3D2. Incase if you are not able to see the attached text file. =
Below
> > > is part of make command output
> > > -------------------------------------
> > >   CC      lib/strncpy_from_user.o - due to target missing
> > >   CC [M]  net/can/j1939/socket.o - due to target missing
> > >   CC      lib/strnlen_user.o - due to target missing
> > > net/can/j1939/socket.c: In function =E2=80=98j1939sk_recvmsg=E2=80=
=99:
> > > net/can/j1939/socket.c:621:2: error: implicit declaration of func=
tion =E2=80=98memcpy_toiovec=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
> > >   ret =3D memcpy_toiovec(msg->msg_iov, skb->data, size);
> > >   ^
> > > net/can/j1939/socket.c:621:26: error: =E2=80=98struct msghdr=E2=80=
=99 has no member named =E2=80=98msg_iov=E2=80=99
> > >   ret =3D memcpy_toiovec(msg->msg_iov, skb->data, size);
> > >                           ^
> > > net/can/j1939/socket.c: In function =E2=80=98j1939sk_sendmsg=E2=80=
=99:
> > > net/can/j1939/socket.c:708:48: error: =E2=80=98struct msghdr=E2=80=
=99 has no member named =E2=80=98msg_iov=E2=80=99
> > >   ret =3D memcpy_fromiovec(skb_put(skb, size), msg->msg_iov, size=
);
> > >                                                 ^
> > > cc1: some warnings being treated as errors
> > >   CC      lib/net_utils.o - due to target missing
> > > make[5]: *** [net/can/j1939/socket.o] Error 1
> > > make[4]: *** [net/can/j1939] Error 2
> > > make[3]: *** [net/can] Error 2
> > > make[2]: *** [net] Error 2
> > > make[2]: *** Waiting for unfinished jobs....
> > >
> > > ---------------------------------------------------
> > >
> > > Regards
> > > Dinesh Velayudham
> > > L&T Technology Services
> > > dinesh.velayutham@lnttechservices.com
> > > +1-309-740-7691
> > >
> > > -----Original Message-----
> > > From: Kurt Van Dijck [mailto:dev.kurt@vandijck-laurijssen.be]
> > > Sent: Saturday, April 09, 2016 6:40 AM
> > > To: Dinesh Velayudham
> > > Cc: gianluca; linux-can@vger.kernel.org
> > > Subject: Re: J1939 Linux
> > >
> > >
> > > --- Original message ---
> > > > Date: Fri, 8 Apr 2016 14:29:02 +0000
> > > > From: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>
> > > > To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, gianluca
> > > > <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org"
> > > >  <linux-can@vger.kernel.org>
> > > > Subject: RE: J1939 Linux
> > > >
> > > > Kurt and Eurek,
> > > > I did follow the same steps except that I did not enable J1939 =
option in menuconfig.
> > > > The build was successful and I am able to install the new custo=
m kernel and reboot without any issues.
> > > > Looks like I am facing the problem only when I enable J1939 opt=
ion under menuconfig.
> > > >
> > > > Hope this helps you to narrow down the problem.
> > >
> > > On my Slackware, I get as far as:
> > >
> > >         INSTALL debian/headertmp/usr/include/linux/wimax/ (1 file=
)
> > >         INSTALL debian/headertmp/usr/include/linux/ (420 files)
> > >         INSTALL debian/headertmp/usr/include/asm/ (65 files)
> > >         Using default distribution of 'unstable' in the changelog
> > >         Install lsb-release or set $KDEB_CHANGELOG_DIST explicitl=
y
> > >         ./scripts/package/builddeb: line 31: dpkg-gencontrol: com=
mand not found
> > >         make[1]: *** [deb-pkg] Error 127
> > >         make: *** [deb-pkg] Error 2
> > >
> > > This is anyhow beyond my expertise.
> > > Since it clearly seems to be caused by my can-j1939, I will help =
to find it. Can you show a bit more output where the build fails?
> > > Possibly with V=3D2 commandline parameter?
> > >
> > > Kurt
> > > L&T Technology Services Ltd
> > >
> > > www.LntTechservices.com<http://www.lnttechservices.com/>
> > >
> > > This Email may contain confidential or privileged information for=
 the intended recipient (s). If you are not the intended recipient, ple=
ase do not use or disseminate the information, notify the sender and de=
lete it from your system.
> >
> L&T Technology Services Ltd
>=20
> www.LntTechservices.com<http://www.lnttechservices.com/>
>=20
> This Email may contain confidential or privileged information for the=
 intended recipient (s). If you are not the intended recipient, please =
do not use or disseminate the information, notify the sender and delete=
 it from your system.
