# radiobox

A base image and action for Toolbx and Distrobox.
A box for Amatuer Radio `distrobox create --image ghcr.io/bpbeatty/radiobox -n radiobox -Y`

## How to use

### Create Box

If you use distrobox:

    distrobox create -i ghcr.io/bpbeatty/radiobox -n radiobox
    distrobox enter radiobox

If you use toolbx:

    toolbox create -i ghcr.io/bpbeatty/radiobox -c radiobox
    toolbox enter radiobox

### Make your own

Fork and add programs to this this image - over time you'll end up with the perfect Amatuer Radio setup for you.
Keeping it as a pet works, though the author recommends leaving all your config in git and routinely pulling a new image.

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/bpbeatty/radiobox

If you're forking this repo you should [read the docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets) on keeping secrets in github. You need to [generate a new keypair](https://docs.sigstore.dev/cosign/overview/) with cosign. The public key can be in your public repo (your users need it to check the signatures), and you can paste the private key in Settings -> Secrets -> Actions.

